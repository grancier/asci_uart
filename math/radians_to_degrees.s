# radians_to_degrees.s: This file contains a function
# to convert an angle in radians, given as a fixed point number,
# to a number of degrees, which is returned as a 16 bit integer
# from 0 to 359. Zero radians = zero degrees.

# Global procedures and functions defined in this file:
.globl radians_to_degrees

# Global procedures and functions called in this file:
.globl lightweight_marshall_parameters_arity_1
.globl multiply_32bits
.globl negate_fp



# radians_to_degrees: Convert a fixed point number of radians to
# an integer number of degrees.  This function follows the 
# standard fixed point number function calling convention for 
# arity 1 functions: see fixed_point.s for details.
#
# Usage:
#    push <pointer to variable area base>
#    push <index of number of radians>0
#    call radians_to_degrees
#    pop <number of degrees as a 16 bit integer>
#    pop <pointer to variable area base>

radians_to_degrees:
				# Stack setup...
				push		ix
				ld			ix,0
				add			ix,sp

				push		af          # Save registers
				push		bc
                push        hl
                push        iy

				ld			a,0			# Clear negation flag

				# Copy IX -> IY, so that the return pointer
				# is stored.
				push		ix
				pop			iy

				call		lightweight_marshall_parameters_arity_1

                # Now IX points to the number of radians.
				# The obvious way to proceed would be to multiply
				# this number by 180 / pi. However, unfortunately,
				# 180 is out of the range of the fixed point number
				# system which can only handle numbers from -127
				# to 127. Therefore, we work with 32 bit numbers
				# in this subroutine. 

				# Load input onto the stack
				ld			h,(ix+3)
				ld			l,(ix+2)
				push		hl
				ld			h,(ix+1)
				ld			l,(ix+0)
				push		hl

				# Is the input negative?
				bit			7,(ix+3)
				jr			z,input_was_positive

				# Yes. Make it positive and set a negation flag.

				ld			hl,0		# make it positive...
				add			hl,sp
				push		hl
				ld			h,0
				push		hl
				call		negate_fp
				pop			hl
				pop			hl

				inc			a			# set a negation flag

input_was_positive:
				# Load 32 bit number ( 180 / pi ) * 16777216 onto the stack
				# This is 961263668.78 = 0x35b84b39 in 32 bits.
				ld			h,0x39
				ld			l,0x4b
				push		hl
				ld			h,0xb8
				ld			l,0x35
				push		hl

				# Get the stack pointer.
				ld			hl,0
				add			hl,sp

				# And push it onto the stack ready for
				# multiply_32bits.
				push		hl
				call		multiply_32bits
				pop			hl

				# We have now calculated:
				# radians * 16777216 * ( 180 / pi ) * 16777216
				# (Radians is multiplied by 16777216, because it is
				# a fixed point value, and 2^24 = 16777216).
				# The degrees value needs to be right shifted
				# to divide by 16777216 * 16777216. This is a
				# shift by 48 bits: 6 bytes.

				pop			bc		# Pop bottom 48 bits of degrees figure.
				pop			bc
				pop			bc
				pop			hl		# Pop the actual degrees figure.

				# If A <> 0, then HL must be negated.
				or			a		# Check zero flag of A.
				jr			z,hl_is_correct

				# Negate HL:
				ld			a,0
				sub			l
				ld			l,a

				ld			a,0
				sbc			a,h
				ld			h,a

hl_is_correct:	# HL contains the number of degrees. 
				# Now we marshall it so that it's in the range 0 - 359.

				# First ensure it's less than 360, by subtracting
				# 360 from it until it becomes negative.
				ld			bc,-360
while_greater_than_360:
				# Subtract 360 from HL.
				add			hl,bc
				bit			7,h			# Is HL negative? Check 16th bit.
				jr			z,while_greater_than_360

				# Now add 360 until HL is greater than zero.
				ld			bc,360
while_less_than_zero:
				add			hl,bc			
				bit			7,h	
				jr			nz,while_less_than_zero

				# Now HL is in the range 0 to 359.
				# Return this value.
				ld			(iy+4),l
				ld			(iy+5),h

				# Restore registers.
				pop			iy
				pop			hl
				pop			bc
				pop			af
				pop			ix
				ret


