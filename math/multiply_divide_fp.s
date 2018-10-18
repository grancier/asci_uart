# multiply_divide_fp.s: Functions in this file allow multiplication
# and division of fixed point numbers.

# Global procedures and functions defined in this file:
.globl multiply_fp 
.globl divide_fp 

# Global procedures and functions called in this file:
.globl multiply_32bits
.globl divide_64bits
.globl transmit_string
.globl trap_interrupt
.globl negate_fp
.globl lightweight_marshall_parameters_arity_1
.globl lightweight_marshall_parameters_arity_2


# Strings:
multiply_overflow_error:
				"\r\nError: Multiplication overflow.\r\n\0"
divide_overflow_error:
				"\r\nError: Division overflow.\r\n\0"




# multiply_fp: Multiply two fixed point numbers together and store the 
# result. This function follows the standard fixed point number
# function calling convention for arity 2 functions: see 
# fixed_point.s for details.
# 
# multiply_fp will print an error message and generate a trap if the
# multiplication generates a value out of the range of fixed point 
# numbers.
# 
multiply_fp:
				# Set up the stack...
				push		ix
				ld			ix,0
				add			ix,sp

				# Store values of registers we intend to use.
				push		af
				push		bc
				push		hl
				push		iy

				# Marshall parameters..
				call		lightweight_marshall_parameters_arity_2

				# Make a copy of both inputs in an area of the stack.
				# (the multiply_32bits function expects both to 
				# follow each other in memory).
				ld			b,(iy+3)
				ld			c,(iy+2)
				push		bc
				ld			b,(iy+1)
				ld			c,(iy+0)
				push		bc
				ld			b,(ix+3)
				ld			c,(ix+2)
				push		bc
				ld			b,(ix+1)
				ld			c,(ix+0)
				push		bc

				# We don't need to keep the pointer IY now, since the
				# data at IY has already been copied and is never
				# changed. Make it point to this area of the stack.
				ld			iy,0
				add			iy,sp

				# Make both inputs positive.
                call        lightweight_make_inputs_positive

				push		af			# Save negation flag (A) on the stack.

                # Now, we're ready to multiply.
                # Push a pointer to the words to be multiplied
                # onto the stack.
                push        iy

                call        multiply_32bits

                pop         bc

				# The multiplication result is a 64 bit number that
				# contains 32 bits that we are interested in. The
				# numbers below the 'decimal' point are in IY+0 to IY+5.
				# The numbers above it are in IY+6 to IY+7.
				# IY+6 becomes the most significant byte of the output
				# 32 bit fixed point number. If IY+7 is non-zero,
				# the an overflow has occurred.

				# Examine IY+7 to check for overflow.
				ld			a,(iy+7)
				cp			0
				jr			nz,multiply_overflow

				# Shift the 4 bytes so the result is in the right place.
				ld			a,(iy+6)		# IY+6 -> IX+3
				ld			(ix+3),a
				ld			a,(iy+5)		# IY+5 -> IX+2
				ld			(ix+2),a
				ld			a,(iy+4)		# IY+4 -> IX+1
				ld			(ix+1),a
				ld			a,(iy+3)		# IY+3 -> IX+0
				ld			(ix+0),a

				pop			af			# Restore negation flag (A) from stack

				cp			0
				jr			z,multiply_no_negation_required

                # Negate the number at IX (the result)
				push		ix
				ld			b,0
				push		bc
				call		negate_fp
				pop			bc
				pop			ix

multiply_no_negation_required:
				# Multiplication complete.
				# Free up the 4 words of temporary stack space:
				pop			bc
				pop			bc
				pop			bc
				pop			bc

				# Restore registers.
				pop			iy
				pop			hl
				pop			bc
				pop			af
				pop			ix
				ret

multiply_overflow:
				# The numbers that were multiplied together
				# were large enough that the result was out
				# of range of the fixed point number system.
				ld			bc,multiply_overflow_error
				push		bc
				call		transmit_string
				pop			bc

				# A trap is generated.
				call		trap_interrupt




# divide_fp: Divide two fixed point numbers. 
# This function follows the standard fixed point number
# function calling convention for arity 2 functions: see 
# fixed_point.s for details.
#
# divide_fp will print an error message and generate a trap if asked
# to divide by zero, or if the division generates a value out of the
# range of fixed point numbers.
# 

divide_fp:
				# Set up the stack...
				push		ix
				ld			ix,0
				add			ix,sp

				# Store values of registers we intend to use.
				push		af
				push		bc
				push		de
				push		hl
				push		iy

				# Marshall parameters..
				call		lightweight_marshall_parameters_arity_2

				# Make a copy of both inputs in an area of the stack.
				# (the divide_32bits function expects both to 
				# follow each other in memory).
				ld			b,(iy+3)
				ld			c,(iy+2)
				push		bc
				ld			b,(iy+1)
				ld			c,(iy+0)
				push		bc
				ld			b,(ix+3)
				ld			c,(ix+2)
				push		bc
				ld			b,(ix+1)
				ld			c,(ix+0)
				push		bc

				# Copy IY to HL:
				push		iy
				pop			hl

				# Make IY point to the new area on the stack.
				ld			iy,0
				add			iy,sp

				# Allocate a further 4 bytes of memory so that
				# the dividend can be made into the 64 bit number
				# that divide_64bits expect:
				ld			bc,0
				push		bc
				push		bc

				# Make both inputs positive.
                call        lightweight_make_inputs_positive

				ld			d,a			# Copy negation flag A to D

				# Move IY back by 4 bytes so that it points to the beginning
				# of this memory area:
				ld			bc,-4
				add			iy,bc

				# Shift the dividend right by 8 bits to make it into an
				# equivalent 64 bit value:
				# This is a change from '0000ttttbbbb' to '000tttt0bbbb'
				ld			a,(iy+4)
				ld			(iy+3),a
				ld			a,(iy+5)
				ld			(iy+4),a
				ld			a,(iy+6)
				ld			(iy+5),a
				ld			a,(iy+7)
				ld			(iy+6),a
				ld			a,0
				ld			(iy+7),a

				# We're now ready to do the division: all the
				# parameters are in place for divide_64bits.

                push        iy
                call        divide_64bits
                pop         bc

				# The quotient returned is a 64 bit number, but we're only
				# interested in the low 32 bits. If the high bits are non-zero
				# then an overflow has occurred and an exception is thrown.

				# Examine high 32 bits (IY+4 .. IY+7) to check for overflow.
				ld			a,0
				cp			(iy+7)
				jr			nz,divide_overflow
				cp			(iy+6)
				jr			nz,divide_overflow
				cp			(iy+5)
				jr			nz,divide_overflow
				cp			(iy+4)
				jr			nz,divide_overflow

				# Restore original IY pointer: it was copied to HL.
				push		hl
				pop			iy

				# No overflow. Free the stack space and copy the
				# quotient and remainder to the correct places.
				pop			bc		# Copy quotient out (low 32 bits)
				ld			(ix+0),c
				ld			(ix+1),b
				pop			bc
				ld			(ix+2),c
				ld			(ix+3),b

				pop			bc		# Ignore high 32 bits of quotient
				pop			bc

				pop			bc		# Could copy remainder out
				pop			bc      # here, but there's no real need

				ld			a,d		# Restore main negation flag

				cp			0
				jr			z,divide_no_quotient_negation_required

				# Need to negate the quotient, which is at IX.
				push		ix
				ld			b,0		# quotient is at index 0.
				push		bc
				call		negate_fp
				pop			bc
				pop			ix

divide_no_quotient_negation_required:
				# Division complete.
				pop			iy
				pop			hl
				pop			de
				pop			bc
				pop			af
				pop			ix
				ret

divide_overflow:
				# The numbers that were divided were such that
				# the result was out of range of the fixed 
				# point number system.
				ld			bc,divide_overflow_error
				push		bc
				call		transmit_string
				pop			bc

				# A trap is generated.
				call		trap_interrupt



# lightweight_make_inputs_positive: this lightweight subroutine
# is used for fixed point multiplication and division. It takes the
# parameters given to the multiply_fp and divide_fp functions and
# makes them both positive by subtracting them from zero if they are
# negative. If exactly one of them was negative, a negation flag in
# the accumulator is set to indicate that the multiply/divide result
# must be negative also.
#
# This subroutine destroys A, F, and BC. IY is used but preserved.
#
lightweight_make_inputs_positive:
                # Accumulator is used as a negation flag. If it is set, the
                # output must be negated.
                ld          a,0

                # Is either word negative? Test the 32nd bit of each.
                bit         7,(iy+7)
                jr          z,word_b_is_positive

                # word b is negative. Complement negation flag.
                cpl         
                
                # make word b positive by subtracting it from zero.
				# push IY - it is the base of the variable area
				# internal to the multiply/divide function. 
				push		iy

				ld			b,1		# word b is at index 1.
				push		bc
				call		negate_fp
				pop			bc

				pop			iy
                
word_b_is_positive:
                bit         7,(iy+3)
                jr          z,word_a_is_positive

                # word a is negative. Complement negation flag.
                cpl         

				# Make word b positive.
				push		iy
				ld			b,0		# word a is at index 1.
				push		bc
				call		negate_fp
				pop			bc
				pop			iy

word_a_is_positive:
				ret

