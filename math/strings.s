# strings.s: Procedures for converting numbers to strings.

# Global procedures and functions defined in this file:
.globl convert_32_bit_number_to_string
.globl convert_fixed_point_number_to_string

# Global procedures and functions called in this file:
.globl divide_64bits
.globl multiply_32bits
.globl negate_fp
.globl multiply_fp
.globl add_fp
.globl lightweight_marshall_parameters_arity_1



# convert_32_bit_number_to_string: Store a 2's complement 32 bit number
# in a string. 
# The procedure takes 2 pointers. The first points to the number to be
# converted. The second points to the string to be written to.
# The string returned is terminated by a zero character. The caller must
# ensure that the string is sufficiently long to hold the number,
# including minus sign and zero terminator. A 32 bit number may use up
# to 12 characters in total.
# Usage:
#       push <pointer to number>
#       push <pointer to place to store the string>
#		call convert_32_bit_number_to_string
#       pop
#       pop

convert_32_bit_number_to_string:
				# Set up the stack...
				push		ix
				ld			ix,0
				add			ix,sp

				push		af
				push		bc
				push		de
				push		hl
				push		iy

				ld			h,0

                # Copy the string pointer into IY.
                ld          d,(ix+5)    # load address of string into DE
                ld          e,(ix+4)
                ld          iy,0        # copy DE to IY
                add         iy,de

				# Set up an area of the stack for some division.
				# We allocate 4 bytes of the stack for the divisor
				# first. 

				ld			bc,0		
				push		bc
				push		bc

				# Load a pointer to the user supplied number into IX.
                ld          b,(ix+7)	# load address of number into BC
                ld          c,(ix+6)
				ld			ix,0		# copy BC to IX
				add			ix,bc

				# Now copy the user supplied number onto the stack.
				# Here, it becomes the dividend for the division
				# later on in this subroutine. The dividend is 64 bits,
				# so the top 32 bits are left as zero.
				ld			bc,0
				push		bc
				push		bc

				ld			b,(ix+3)	# High byte of the user supplied number
				ld			c,(ix+2)
				push		bc		
				ld			b,(ix+1)	
				ld			c,(ix+0)	# Low byte of the user supplied number
				push		bc		

				# Make IX point to the start of this space.
				# IX+0 points to the dividend.
				# IX+8 points to the divisor.
				ld			ix,0
				add			ix,sp	

				# Is the user's number negative? Check 32nd bit.
				bit			7,(ix+3)
				jr			z,conv_32_number_is_positive

				# Yes: make it positive.
				# We can do this by treating it as a fixed point number
				# temporarily.
				push		ix
				ld			a,0
				push		af
				call		negate_fp
				pop			af
				pop			ix

				# set a flag in register H to indicate that this
				# has happened.
				ld			h,1

conv_32_number_is_positive:
				push		ix		# Put pointer on the stack
									# so that divide_64bits can use it.

repeat_division:
				# Store divisor in the appropriate space: IX+8.
				ld			(ix+8),10		# divisor = 10: decimal arithmetic

				# Repeatedly carry out a division process using
				# this dividend and divisor. At each stage,
				# the remainder is another number to be written out.
				
				call		divide_64bits

				ld			a,(ix+8)		# remainder.
				add			a,'0'			# convert remainder to ASCII
				ld			(de),a			# write to output
				inc			de

				# When the quotient is zero, there are no further numbers,
				# and we can stop the division process. To tell if
				# the quotient is zero we logically OR all the bytes of
				# it together. (All the bytes that could be set, at any
				# rate, which is the low 4 bytes).
				ld			a,(ix+0)		# quotient.
				or			(ix+1)
				or			(ix+2)
				or			(ix+3)
				cp			0
				jr			nz,repeat_division

				# Done with division, so remove pointer from the stack.
				pop			ix

				# and remove the area allocated for the dividend and divisor
				pop			bc
				pop			bc
				pop			bc
				pop			bc
				pop			bc
				pop			bc

				# If H is non-zero, write a minus sign.
				ld			a,h
				cp			0
				jr			z,skip_minus_sign

				ld			a,'-'
				ld			(de),a
				inc			de

skip_minus_sign:
				# Put a zero character on the end of the string.
				ld			a,0
				ld			(de),a

				# Move DE back to the last actual character.
				dec			de

				# Now the number is in the string buffer.
				# Only problem: it's written backwards!
				# Begin swapping the first and last digits.

				# Copy IY to BC.
				push		iy
				pop			bc

				# The last digit is (DE). The first digit is (BC).

swap_first_and_last:
				# Swap (DE) and (BC)
				ld			a,(de)		# copy (DE) -> H
				ld			h,a

				ld			a,(bc)		# copy (BC) -> (DE)
				ld			(de),a

				ld			a,h			# copy H -> (BC)
				ld			(bc),a		


				# Decrement DE, increment BC
				dec			de
				inc			bc

				# Now, is DE < BC?
				ld			a,d
				cp			b
				jr			nz,check_sign_of_comparison

				ld			a,e
				cp			c
check_sign_of_comparison:
				jp			p,swap_first_and_last

				# DE = IY. Exit loop.
				# We are done. A null terminated string containing
				# the provided number is now at the supplied address.

				pop			iy
				pop			hl
				pop			de
				pop			bc
				pop			af
				pop			ix
				ret




# convert_fixed_point_number_to_string: Store a fixed point number
# as a string to a user-specified level of precision. This function
# is similar to other fixed point number functions in that it takes
# a variable area start pointer, and an index. (See fixed_point.s
# for more details).
#
# It also takes a precision number and a pointer to the string to 
# be written to. The string returned is terminated by a zero 
# character. The caller must ensure that the string is sufficiently 
# long to hold the number, including minus sign and zero terminator. 
# The final parameter, the precision number, is the number of 
# decimal places that should follow the number. This number may be zero.
# 
# Note: the output is rounded to the nearest representable value 
# (up or down). The output string must be long enough to hold the 
# output number, including any minus sign and decimal point.
#
# Usage:
#       push <pointer to place to store the string>
#       push <number of decimal places>0
#       push <pointer to variable area>
#       push <index of fixed point number within area>0
#		call convert_fixed_point_number_to_string
#       pop
#       pop
#       pop
#       pop

convert_fixed_point_number_to_string:
				# Set up the stack...
				push		ix
				ld			ix,0
				add			ix,sp

				push		af
				push		bc
				push		de
				push		hl
				push		iy

				# Copy IX -> IY.
				push		ix
				pop			iy

				call		lightweight_marshall_parameters_arity_1

                # Now IX points to the number to be processed,
				# and IY points to the parameters.

				# Copy number of decimal places into H.
				ld			h,(iy+9)

				# Set negation flag L to zero.
				ld			l,0		

                # Copy the string pointer into IY.
                ld          d,(iy+11)   # load address of string into DE
                ld          e,(iy+10)
                ld          iy,0        # copy DE to IY
                add         iy,de

                # Make a space on the stack containing
                # 0.5 in fixed point. This will be at index 2.
                ld          bc,0x0080
                push        bc
                ld          c,0
                push        bc

                # Make a space on the stack containing
                # 0.1 in fixed point. This is 0x9a991900.
                # This will be at index 1.
                ld          bc,0x0019
                push        bc
                ld          bc,0x999a
                push        bc

				# IX points to the number to be processed...
                # Copy the number onto the stack.
                # This will be at index 0.
                ld          b,(ix+3)
                ld          c,(ix+2)
                push        bc
                ld          b,(ix+1)
                ld          c,(ix+0)
                push        bc

                # and make IX point to it.
                ld          ix,0
                add         ix,sp

				# Is the input number negative? Test the 8th bit to find out.
				bit			7,(ix+3)
				jr			z,conv_fp_number_is_positive

				# Yes. Add a minus sign to the front of the string.
				ld			a,'-'
				ld			(iy),a
				inc			iy

                # And negate the number.
				push		ix
                ld          a,0
                push        af
				call		negate_fp
                pop         af
                pop         ix

				# Set negation flag in L.
				ld			l,1

conv_fp_number_is_positive:
                # For rounding purposes, we add 0.5 * 10 ^ -number of d.p.
                # So if we're displaying to 1 d.p., we add 0.05 to the
                # input, so that the numbers are rounded up.

                push        ix          # Push variable area base pointer

                # If number of d.p. = 0, then skip this part.
                ld          a,0
                cp          h
                jr          z,skip_rounding_number_multiplication

                # First multiply 0.5 * 10 ^ - number of d.p.
                ld          bc,0x0201   # Multiply index 2 and index 1
                push        bc

                ld          b,h         # Set loop counter
rounding_number_multiplication:
                call        multiply_fp
                djnz        rounding_number_multiplication

                pop         bc

skip_rounding_number_multiplication:
                # Now add 0.5 * 10 ^ - number of d.p. to the input
                # number.
                ld          bc,0x0002       # Add index 2 to index 0
                push        bc
                call        add_fp
                pop         bc

                pop         de          # Pop variable area base pointer

				# Store the digits to the left of the 'decimal point' in A.
				ld			a,(ix+3)

				# Make a 64 bit space on the stack, and fill it with the
				# digits to the left of the 'decimal point' in the input
				# number.
				# The input number 'aaa.b' is copied to 'b0000000'.

				ld			bc,0
				push		bc
				push		bc
				push		bc
				ld			c,a
				push		bc

				ld			ix,0	
				add			ix,sp		# Make IX point to this new space.

				# Call convert_32_bit_number_to_string to display
				# the digits to the left of the decimal point.
				push		ix			# Push number location.
				push		iy			# Push string location.
				call		convert_32_bit_number_to_string 
				pop			iy
				pop			ix

				# Did the user want any decimal places? 
				# The number requested is stored in H.
				ld			a,h
				cp			0
				jp			z,no_decimal_places_requested

				# Yes. First, increase IY (the pointer to the string)
				# until the zero terminator is reached.

find_zero_terminator:
				inc			iy
				ld			a,(iy)
				cp			0
				jr			nz,find_zero_terminator

				# Put a decimal point in the string.
				ld			a,'.'
				ld			(iy),a
				inc			iy

				# Prepare to write the digits following the decimal point.
				# First, copy the digits to the right of the 'decimal point'
				# into the space allocated on the stack earlier.
				# DE points to the input number, and IX points to the
				# space on the stack.

				# Save IY, and then copy DE to IY
				push		iy
				ld			iy,0
				add			iy,de

				ld			a,(iy+0)
				ld			(ix+0),a
				ld			a,(iy+1)
				ld			(ix+1),a
				ld			a,(iy+2)
				ld			(ix+2),a
				ld			a,0			# Do not copy the digits to the
				ld			(ix+3),a	# left of the decimal point

				pop			iy			# Restore IY after copy.

				# Now IX points to the digits to the right of the decimal
				# point from the user supplied value.

				# H contains the number of decimal places to
				# be displayed. Copy this to B to be used as a loop
				# counter.
				ld			b,h

multiplication_loop:
				# For every decimal digit to be extracted,
				# multiply the number at IX by 10. Since multiply_32bits
				# will multiply two adjacent 32 bit words into one 64 bit
				# word, we arrange that the 32 bit word adjacent to IX
				# should contain the number 10:
				ld			a,10
				ld			(ix+4),a

				# Do the multiplication:
				push		ix
				call		multiply_32bits
				pop			ix

				# extract the number from the high byte. This will
				# be a number from 0 to 9. It is the next number
				# that should be written to the string.
				ld			a,(ix+3)

				# Turn it into ASCII..
				add			a,'0'
				# and place it at the current position in the string (IY).
				ld			(iy),a

				# zero the high byte.
				ld			a,0
				ld			(ix+3),a

				# Next string position.
				inc			iy

				# Decrement B, and repeat the process.
				djnz		multiplication_loop

				# Write a null terminator to the string.
				ld			(iy),a

no_decimal_places_requested:
				# Free up space allocated on the stack
                # This is 4 words for the 32 bit multiply, etc,
                # and 6 words for the negation/rounding.
                ld          b,4+6
free_up_stack:  pop         hl
                djnz        free_up_stack


				# Restore registers
				pop			iy
				pop			hl
				pop			de
				pop			bc
				pop			af
				pop			ix
				ret
