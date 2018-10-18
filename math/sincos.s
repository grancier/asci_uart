# sincos.s: Sine and cosine functions, for the fixed point number format.
# The abstract linear interpolator (ALI) is used.

# Global procedures and functions defined in this file:
.globl sine
.globl cosine

# Global tables used by this file:
.globl sine_table_start


# Global procedures and functions used in this file:
.globl subtract_fp
.globl multiply_fp
.globl divide_fp
.globl divide_64bits
.globl add_fp
.globl negate_fp
.globl compare_fp
.globl identity_fp
.globl ali
.globl lightweight_marshall_parameters_arity_1


# sine: The sine of the input angle, specified in radians in the fixed point
# number format, is calculated and stored as a fixed point number.
# This function follows the standard fixed point number function calling 
# convention for arity 1 functions: see fixed_point.s for details.

sine:		
				# Set up the stack...
				push		ix
				ld			ix,0x0000
				add			ix,sp

				# This function uses practically all the
				# registers... store their old values now.
				push		af
				push		bc
				push		de
				push		hl
				push		iy

				# Load the input/output pointer into IX:
				call		lightweight_marshall_parameters_arity_1

				# Clear negation flag.
				ld			d,0

                # Is the input angle negative? If it is, make it positive.
                # sin ( -x ) = - sin ( x ), so the negation flag must be flipped.

                # Is the input negative? Check the 32nd bit:
                bit         7,(ix+3)
                jr          z,input_is_positive

                # Yes. Negate it now to make it positive.
                push        ix
                ld          a,0
                push        af
                call        negate_fp
                pop         af
                pop         ix

                # and flip the negation flag.
                ld          d,0xff     # (D = 0 to start with)

input_is_positive:
                # Apply the operation "modulo 2 pi" to the input. This ensures
                # that the input is in the range zero to 2pi. The 64 bit
                # division routine is used for this operation which essentially
                # finds the remainder.
                # The operation is really fast if the angle is already less 
                # than 2pi.

                # Put divisor (2 pi) on the stack:
                # In fixed point, 2 pi is 0xd57e4806
                ld          hl,0x0648       # high word first
                push        hl
                ld          hl,0x7ed5       # low word next
                push        hl

                # Put dividend (input angle) on the stack.
                # Convert it to 64 bits by putting 4 zero bytes before it.
                ld          hl,0
                push        hl
                push        hl
                ld          h,(ix+3)
                ld          l,(ix+2)
                push        hl
                ld          h,(ix+1)
                ld          l,(ix+0)
                push        hl

                # Do the division by making IY point to this area of the stack:
				ld			iy,0
				add			iy,sp
                push        iy
                call        divide_64bits
                pop         iy

                # Keep this space on the stack. The quotient is in the
                # 8 bytes following IY - it's not important. The remainder
                # is in the 4 bytes following that. This is the value
                # that we should be using as the input.

                # The input is between 0 and 2 pi.
                # The sine table is only defined for 0 to 1/2 pi, though,
                # since that section of the curve is sufficient to
                # easily reconstruct the rest. 

				# Here we transform the angle to the appropriate
				# place on that curve if necessary.
			
                # Load pi into the space previously occupied by the
                # quotient (IY). pi = 0x6b3f2403 in fixed point.
                ld          hl,0x3f6b
                ld          (iy+0),l
                ld          (iy+1),h
                ld          hl,0x0324
                ld          (iy+2),l
                ld          (iy+3),h

                # Load half pi into the space at (IY+4)
                # half pi = 0xb51f9201 in fixed point.
                ld          hl,0x1fb5
                ld          (iy+4),l
                ld          (iy+5),h
                ld          hl,0x0192
                ld          (iy+6),l
                ld          (iy+7),h

				# Is the angle >= pi?
                # sin ( x ) = - sin ( x + pi )
                push        iy          # push pointer to variable area.
                ld          bc,0x0200   # compare input (at index 2)
                                        # with pi (at index 0)
                push        bc
                call        compare_fp
                pop         af
                pop         iy

                # If A = -1, then angle < pi.
                cp          -1
                jr          z,angle_is_not_greater_than_pi

				# Flip the negation flag.
				ld			a,d
                cpl
				ld			d,a

				# Subtract pi from the angle. 
                push        iy          # push pointer to variable area
                ld          bc,0x0200   # subtract pi (at index 0)
                                        # from input (at index 2)
                push        bc
                call        subtract_fp 
                pop         bc
                pop         iy

angle_is_not_greater_than_pi:
				# Is the angle greater than 1/2 pi now?
                # sin ( x ) = sin ( pi - x )
                # Half pi is at the space at (IY+4)..

                push        iy          # push pointer to variable area
                ld          bc,0x0201   # compare input (at index 2)
                                        # with half pi (at index 1)
                push        bc
                call        compare_fp
                pop         af
                pop         iy

                # if A = 1, then angle > half_pi
                cp          1
                jr          nz,angle_is_not_greater_than_half_pi

                # Angle > half_pi.
                # Subtract the angle from pi.
                push        iy          # push pointer to variable area
                ld          bc,0x0002   # subtract input (2) from pi (0).
                push        bc
                call        subtract_fp
                pop         bc
                pop         iy

                # Copy the result of the subtraction from
                # index 0 to index 2 within the variable area.
                push        iy
                ld          bc,0x0200
                push        bc
                call        identity_fp
                pop         bc
                pop         iy

angle_is_not_greater_than_half_pi:
                # so 0 <= angle <= 1/2 pi.

                # Now transform the angle so it is in the range 0 to 1.0,
                # by dividing by 1/2 pi. This allows us to use the
                # abstract linear interpolator. We divide the number at
                # index 2 with the number at index 1 (half pi) within
                # the variable area.

                push        iy          # push pointer to variable area
                ld          bc,0x0201   # divide input by half pi
                push        bc
                call        divide_fp
                pop         bc
                pop         iy

                # HL points to the quotient.
                # Push the location of the sine table onto the stack.
                ld          bc,sine_table_start
                push        bc
                # push the pointer to the variable area too...
                push        iy
                # and the index of the number we're interested in (2)
                ld          bc,0x0200
                push        bc

                # Call the abstract linear interpolator to convert the
                # quotient (a value from 0 to 1) into the sine of the
                # angle using the table.
                call        ali

                pop         bc
                pop         iy
                pop         bc

                # If the negation flag d is set, then the result must
                # be negated.
                ld          a,d
                cp          0
                jr          z,no_negation_needed

                # Negate result
                push        iy
                ld          bc,0x0200
                push        bc
                call        negate_fp
                pop         bc
                pop         iy

no_negation_needed:
                # Free the 8 bytes on the stack occupied
                # by half pi and pi.
                pop         hl
                pop         hl
                pop         hl
                pop         hl 
                # Copy the result from the stack to IX.
                pop         hl
                ld          (ix+0),l
                ld          (ix+1),h
                pop         hl
                ld          (ix+2),l
                ld          (ix+3),h

				# Restore register values.
				pop			iy
				pop			hl
				pop			de
				pop			bc
				pop			af
				pop			ix

				ret


# cosine: The cosine of the input angle, specified in radians in the fixed point
# number format, is calculated and stored as a fixed point number.
# This function follows the standard fixed point number function calling 
# convention for arity 1 functions: see fixed_point.s for details.

cosine:		
				# Set up the stack...
				push		ix
				ld			ix,0x0000
				add			ix,sp

				# cos(x) = sin(x + 1/2pi)
				# This allows us to reuse the sine function.

                push        af
				push		bc
				push		hl

				# Load the input/output pointer into IX:
				call		lightweight_marshall_parameters_arity_1

                # Add half pi to the input angle. To do this,
                # put half pi on the stack along with the number from IX:
				# half pi = 0xb51f9201 in fixed point
                ld          bc,0x0192
                push        bc
                ld          bc,0x1fb5
                push        bc
                ld          c,(ix+2)
                ld          b,(ix+3)
                push        bc
                ld          c,(ix+0)
                ld          b,(ix+1)
                push        bc

                # Make HL point to this area.
                ld          hl,0
                add         hl,sp

                push        hl              # push pointer to start of
                                            # variable area.
                ld          bc,0x0001
                push        bc
                call        add_fp          # add number to half pi
                call        sine            # calculate sine of result
                pop         bc

                pop         hl

                # Unload the result from the stack to IX:
                pop         bc
                ld          (ix+0),c
                ld          (ix+1),b
                pop         bc
                ld          (ix+2),c
                ld          (ix+3),b

                # and destroy the copy of half pi:
                pop         bc
                pop         bc

				# Done..
                pop         hl
				pop			bc
				pop			af
				pop			ix

				ret

