# fixed_point.s: The base subroutines used by all fixed point 
# subroutines to implement the calling convention.


# Global procedures and functions defined in this file:
.globl lightweight_marshall_parameters_arity_1
.globl lightweight_marshall_parameters_arity_2
.globl identity_fp

# The fixed point number format:
#
# The format of the fixed point number used in this project is 
# quite simply 8.24 bits. There are 8 bits to the left of the
# 'decimal' point and 24 bits to the right. The number is stored
# as a 2's complement value, giving a range from -128 to +127.
# The numbers are accurate to better than 1.0x10^-7, quite close
# to that of a 32 bit IEEE float.

# The calling convention for fixed point number functions:
# 
# All fixed point functions are called in a consistent way. The
# typical caller will call a series of functions to process some
# data from one form to another: take the sine of two numbers,
# multiply them, etc. This is made easy by the 'variable area'
# concept. The caller keeps all the variables to be modified
# in an area of memory: the pointer to the beginning of this area
# is stored on the stack. Each call to a fixed point function
# is made using the index or indexes of the values the function
# should be applied to. Index 0 is the first 4 bytes of the
# variable area, index 1 is the second, and so on.
#
# Arity 1 functions are called as follows:
#
#	push		<ptr to start of variable area>
#	push		<index within area>0
#	call		function
#   pop
#   pop
#
# (The number at <index within area> is modified in place).
# for example:
#	negate: X = 0 - X
#
# Arity 2 functions are called as follows:
#
#	push		<ptr to start of variable area>
#	push		<index of X/result><index of Y>
#	call		function
#
# (The number at <index of X/result> is modified in place).
# for example:
#	add: X = X + Y
#	subtract: X = X - Y
#	multiply: X = X * Y
#   divide: X = X / Y
# 
# Some functions work slightly differently. compare_fp returns
# a compare result in place of the index word:
#   compare: X <=> Y   (X > Y.. returns 1, etc)



# lightweight_marshall_parameters_arity_1:
# This lightweight subroutine implements the calling convention
# used by all fixed point number functions: add, multiply, etc..
# The user is expected to have pushed two things onto the stack
# before calling any fixed point number function: a pointer to
# the start of the current variable area, and an index within
# that area. From these, the correct place in the area is located
# and a pointer to it is loaded into IX. See above for an example
# of the calling convention in use.
# 
# Before calling this lightweight subroutine, the caller must
# ensure that IX points to the start of the stack frame, achieved
# with the following code fragment at the beginning of the subroutine:
#                   push		ix
#                   ld			ix,0
#                   add			ix,sp
# The subroutine overwrites IX with the correct pointer,
# and also destroys AF, BC and HL.

lightweight_marshall_parameters_arity_1:
				# Make HL point to the beginning of the variable area.
				ld			h,(ix+7)
				ld			l,(ix+6)

				# Load index into BC, multiplying by 4
				# (the width of a fixed point number).
				ld			b,4
				ld			c,(ix+5)
				mlt			bc

				# Make HL point to the correct place.
				add			hl,bc

				# Copy HL to IX.
				push		hl
				pop			ix

				ret

# lightweight_marshall_parameters_arity_2:
# This lightweight subroutine implements the calling convention
# used by all fixed point number functions: add, multiply, etc..
# The user is expected to have pushed two things onto the stack
# before calling any fixed point number function: a pointer to
# the start of the current variable area, and two indexes within
# that area. The first index is for the first parameter of the
# function and the place to store the result. The second is for the 
# second parameter only. IX is made to point to the first location,
# and IY is made to point to the second.
# 
# Before calling this lightweight subroutine, the caller must
# ensure that IX points to the start of the stack frame, achieved
# with the following code fragment at the beginning of the subroutine:
#                   push		ix
#                   ld			ix,0
#                   add			ix,sp
# The subroutine overwrites IX and IY with the correct pointers,
# and also destroys AF, BC and HL.

lightweight_marshall_parameters_arity_2:
				# Do second parameter:
				# Make HL point to the beginning of the variable area.
				ld			h,(ix+7)
				ld			l,(ix+6)

				# Load index into BC, multiplying by 4
				# (the width of a fixed point number).
				ld			b,4
				ld			c,(ix+4)
				mlt			bc

				# Make HL point to the correct place.
				add			hl,bc

				# Copy HL to IY.
				push		hl
				pop			iy

				# Do the first parameter:
				call		lightweight_marshall_parameters_arity_1

				ret

# identity_fp: An arity two function in which the result, X, is set equal
# to the second parameter, Y. This is useful for copying numbers within
# a variable area. This function follows the standard fixed point number
# function calling convention for arity 2 functions: see 
# fixed_point.s for details.
identity_fp:
				# Stack setup...
				push		ix
				ld			ix,0
				add			ix,sp

				push		af          # Save registers
				push		bc
				push		iy

				call		lightweight_marshall_parameters_arity_2

                # Now IX points to X, the result
                # and IY points to Y, the second parameter
                
                # Do the copy: 4 bytes from (IY) to (IX)
                ld          a,(iy+0)
                ld          (ix+0),a

                ld          a,(iy+1)
                ld          (ix+1),a

                ld          a,(iy+2)
                ld          (ix+2),a

                ld          a,(iy+3)
                ld          (ix+3),a


                # restore registers.
                pop         iy
                pop         bc
                pop         af
                pop         ix
                ret

