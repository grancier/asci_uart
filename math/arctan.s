# arctan.s: Arctangent function.

# Global procedures and functions defined in this file:
.globl arctan

# Global tables used by this file:
.globl arctan_table_start

# Global procedures and functions used in this file:
.globl subtract_fp
.globl multiply_fp
.globl divide_fp
.globl add_fp
.globl negate_fp
.globl compare_fp
.globl identity_fp
.globl ali
.globl lightweight_marshall_parameters_arity_2


# Constants used in this file:
# (these are bitfield flags)
flag_x_is_greater_than_y = 1
flag_x_is_less_than_zero = 2
flag_y_is_less_than_zero = 4


# arctan: Calculate the arctangent of Y / X, as a fixed point number
# in radians. The signs of Y and X are taken into account in calculating
# the result. It is legal for either to be zero.
#
# This function follows the standard fixed point number function calling 
# convention for arity 1 functions: see fixed_point.s for details.
# essentially Result = X = atan ( Y / X ) .
#
# The operation of this arctan function is similar to the C function
# atan2. It takes two values, X and Y, and returns the arctangent of
# Y / X. Effectively, this is the angle of the point (X,Y) from the
# origin (with the angle of the X axis being zero). The function takes
# into account the quadrant of the input, and is thus able to produce
# a result from - pi to + pi. The output angle is given in radians,
# in the fixed point number format.
# 
arctan:			push		ix
				ld			ix,0x0000
				add			ix,sp

				# This function uses practically all the
				# registers... store their old values now.
				push		af
				push		bc
				push		de
				push		hl
				push		iy

				# Load the input/output pointers into IY and IX:
				call		lightweight_marshall_parameters_arity_2


				# First, make copies of the X and Y values on the stack.

				# Copy Y value onto the stack.
				ld			b,(iy+3)
				ld			c,(iy+2)
				push		bc
				ld			b,(iy+1)
				ld			c,(iy+0)
				push		bc

				# Make HL point to the bottom of the stack
				# at this point, so that we have a pointer to
				# our copy of Y.
				ld			hl,0
				add			hl,sp

				# Copy X value onto the stack
				ld			b,(ix+3)
				ld			c,(ix+2)
				push		bc
				ld			b,(ix+1)
				ld			c,(ix+0)
				push		bc

				# Make IY point to the bottom of the stack
				# so that X and Y may be accessed easily.
				# IY points to our copy of X.
				ld			iy,0
				add			iy,sp
				
				ld			a,0
				# Begin by working out which quadrant
				# the X,Y position is in. To do this,
				# we work out 3 things about X and Y:
				# (1) is X >= 0?
				# (2) is Y >= 0?
				# (3) is |X| >= |Y| ?

				# First: is X >= 0? Check 32nd bit of X.
				bit			7,(iy+3)
				jr			z,x_is_greater_than_zero

				# X < 0. Set a flag to indicate this.
				or			flag_x_is_less_than_zero

				# Negate X. IY points to X.
				push		iy
                ld          bc,0x0000
                push        bc
				call		negate_fp
                pop         bc
				pop			iy

x_is_greater_than_zero:
				# Now: is Y >= 0? Check 32nd bit of Y.
				bit			7,(iy+7)
				jr			z,y_is_greater_than_zero

				# Y < 0. Set a flag to indicate this.
				or			flag_y_is_less_than_zero

				# Negate Y. HL points to Y.
				push		hl
                ld          bc,0x0000
                push        bc
				call		negate_fp
                pop         bc
				pop			hl

y_is_greater_than_zero:
				# Now: is |X| >= |Y| ? 
				# We already have |X| and |Y| since
				# they were negated above iff they were
				# negative.

				push		iy		# pointer to variable area.
                ld          bc,0x0001   # compare X (index 0) to
                                        # Y (index 1)
				push		bc
				call		compare_fp
				pop			bc		# B contains comparison result.
				pop			iy

				# Copy flags to C.
				ld			c,a

				# if B = negative, then X < Y.
				# Check the 8th bit of B.
				bit			7,b
				jr			nz,x_is_less_than_y

				# X >= Y. Set a flag to indicate this.
				or			flag_x_is_greater_than_y

				# Copy updated flags to C.
				ld			c,a

				# Swap X and Y around on the stack.
				ld			a,(iy+0)
				ld			b,(iy+4)
				ld			(iy+0),b
				ld			(iy+4),a

				ld			a,(iy+1)
				ld			b,(iy+5)
				ld			(iy+1),b
				ld			(iy+5),a

				ld			a,(iy+2)
				ld			b,(iy+6)
				ld			(iy+2),b
				ld			(iy+6),a

				ld			a,(iy+3)
				ld			b,(iy+7)
				ld			(iy+3),b
				ld			(iy+7),a

x_is_less_than_y:
				# At this point, we know that the first
				# value on the stack is less than the second.
				# Both numbers are positive.
				
				# We also have a group of 3 flags in C which
				# indicate how the result of the arctangent
				# should be transformed to get the correct
				# result.

				# Divide the first number by the second,
				# ( |Y| / |X| , or |X| / |Y| ). The result
				# is guaranteed by the work above to be in
				# the range 0.0 to 1.0. A divide by zero
				# error can only occur if both X and Y are zero,
				# in which case the user should (and will) be told!

				push		iy
                ld          de,0x0001
                push        de
				call		divide_fp
                pop         de
				pop			iy

				# The resulting quotient is at IY.

                # Now, use the abstract linear interpolator (ALI)
                # to translate this to an arctangent using the
                # arctan table.
                ld          de,arctan_table_start
                push        de      # push pointer to the table onto the stack
                push        iy      # push pointer to the variable area
                ld          de,0    # push index of the number to use (0)
                push        de
                call        ali
                pop         de
                pop         iy 
                pop         de

                # The resulting arctangent is at IY.
                # It must now be transformed in such a way
                # as to reverse the transformations that were
                # applied to make X and Y positive, etc. These
                # transformations are listed as flags in C.

                ld          a,c
                and         flag_x_is_greater_than_y
                jr          z,x_was_less_than_y

                # X was greater than Y. Subtract the result from 1/2 pi.
                # Do this by loading 1/2pi into the area beginning at
                # (IY+4)...
                ld          de,0x1fb5
                ld          (iy+4),e
                ld          (iy+5),d
                ld          de,0x0192
                ld          (iy+6),e
                ld          (iy+7),d
                
                push        iy
                ld          de,0x0100       # subtract result at index 0
                                            # from 1/2 pi at index 1
                push        de
                call        subtract_fp
                pop         de

                # Copy the result of the subtraction from index 1 to
                # index 0.
                ld          de,0x0001
                push        de
                call        identity_fp
                pop         de
                pop         iy

x_was_less_than_y:
                ld          a,c
                and         flag_x_is_less_than_zero
                jr          z,x_was_greater_than_zero

                # X was less than zero.
                # Negate the result.
                push        iy
                ld          de,0
                push        de
                call        negate_fp
                pop         de
                pop         iy

x_was_greater_than_zero:
                ld          a,c
                and         flag_y_is_less_than_zero
                jr          z,y_was_greater_than_zero

                # Y was less than zero. Subtract the result from pi.
                # Do this by loading pi into the area beginning at
                # (IY+4)...
                ld          de,0x3f6b
                ld          (iy+4),e
                ld          (iy+5),d
                ld          de,0x0324
                ld          (iy+6),e
                ld          (iy+7),d
                
                push        iy
                ld          de,0x0100       # subtract result at index 0
                                            # from pi at index 1
                push        de
                call        subtract_fp
                pop         de

                # Copy the result of the subtraction from index 1 to
                # index 0.
                ld          de,0x0001
                push        de
                call        identity_fp
                pop         de
                pop         iy

y_was_greater_than_zero:
                # Right, the result is now in the correct
                # quadrant. 
                
                # Load the result from (IY) to (IX).
                ld          a,(iy+0)
                ld          (ix+0),a
                ld          a,(iy+1)
                ld          (ix+1),a
                ld          a,(iy+2)
                ld          (ix+2),a
                ld          a,(iy+3)
                ld          (ix+3),a

                # Free the 8 bytes of stack
                pop         bc
                pop         bc
                pop         bc
                pop         bc


				pop         iy
				pop         hl
				pop         de
				pop         bc
				pop         af
                pop         ix
                ret

