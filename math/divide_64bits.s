# divide_64bits.s: A 64-bit divider.

# Global procedures and functions defined in this file:
.globl divide_64bits

# Global procedures and functions called in this file:
.globl trap_interrupt
.globl transmit_string

# Constants used in this file:



# divide_64bits: This is a general radix-2 division algorithm that works for
# positive integers, returning a remainder and quotient.
# A 64 bit integer (the dividend) is divided by a 32 bit integer (the divisor)
# to produce a 64 bit result (the quotient) and a 32 bit remainder.
# 
# The function must be passed a single pointer which points to the
# 64 bit dividend followed by the 32 bit divisor.
# The result is stored in the same place: the 64 bit quotient
# followed by the 32 bit remainder.
# 
# In memory:
#   before divide_64bits runs, word_ptr points to 'aaaaaaaabbbb'
#         aaaaaaaa - 64 bit word (Dividend)   
#         bbbb - 32 bit word (Divisor)
#   after divide_64bits runs, word_ptr points to 'qqqqqqqqrrrr'
#         qqqqqqqq - 64 bit quotient
#         rrrr - 32 bit remainder
# 
# Usage:
#       push word_ptr
#       call divide_64bits
#       pop
# 
# The procedure will generate a trap if asked to divide a negative
# number, or asked to divide by zero, and print a suitable error message
# to the serial line.

divide_64bits:
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

                # Copy the parameter into IX. IX will then point to
                # the area of memory where the two input words are. 
                # This area contains the dividend followed by the divisor.
                ld          b,(ix+5)    # load address of number into BC
                ld          c,(ix+4)
                ld          ix,0        # copy BC to IX
                add         ix,bc

				# The divisor and dividend are copied onto the
				# local variable stack for this function so that
				# the subroutines that carry out operations on
				# them can find them easily. Space is allocated
				# on the stack for the quotient (called q here),
				# the remainder (r), the dividend (called t, as in 'top'),
				# and the divisor (called b, as in 'bottom').
				ld			iy,0
				push		iy		# remainder (32 bits)
				push		iy		# remainder
				push		iy		# quotient (64 bits)
				push		iy		# quotient
				push		iy		# quotient
				push		iy		# quotient

				# Now copy the divisor into the stack.
				ld			b,(ix+11)
				ld			c,(ix+10)
				push		bc
				ld			b,(ix+9)
				ld			c,(ix+8)
				push		bc

				# and copy the dividend into the stack
				ld			b,(ix+7)
				ld			c,(ix+6)
				push		bc
				ld			b,(ix+5)
				ld			c,(ix+4)
				push		bc
				ld			b,(ix+3)
				ld			c,(ix+2)
				push		bc
				ld			b,(ix+1)
				ld			c,(ix+0)
				push		bc

				# Make IY point to the bottom of this local
				# variable area.
				add			iy,sp

				# quotient = q = ( divisor / dividend ) = ( t / b )

				# The following constants are used for fast access
				# to the divisor, dividend, quotient, and remainder:
						r3 = 23 # access to the remainder... (r)
						r2 = 22
						r1 = 21
						r0 = 20
						q7 = 19 # access to the quotient... (q)
						q6 = 18
						q5 = 17
						q4 = 16
						q3 = 15
						q2 = 14
						q1 = 13
						q0 = 12
						b3 = 11	# access to the divisor... (b = bottom)
						b2 = 10
						b1 = 9
						b0 = 8
						t7 = 7	# access to the dividend... (t = top)
						t6 = 6
						t5 = 5
						t4 = 4
						t3 = 3
						t2 = 2
						t1 = 1
						t0 = 0


				# Initial sanity checks: Is divisor zero?
				ld			a,(iy+b0)
				or			(iy+b1)
				or			(iy+b2)
				or			(iy+b3)
				jp			z,divide_by_zero_error

				# Initial sanity checks: Is either the dividend
				# or the divisor negative?
				# Determine this by checking the most significant bit of each.
				# (The division algorithm cannot handle negative numbers).
				bit			7,(iy+b3)
				jp			nz,negative_input_error
				bit			7,(iy+t7)
				jp			nz,negative_input_error

				# Initial sanity checks: Is dividend < divisor?
				# If yes, then the quotient = 0 and the remainder = dividend.
				# We handle this as a special case because the
				# division algorithm cannot otherwise cope with this
				# situation.

				# If any of the high 32 bits of the dividend
				# are set, then we know for certain that the
				# dividend must be greater than the divisor.

				ld			a,0
				cp			(iy+t7)
				jr			nz,sanity_checks_passed

				cp			(iy+t6)
				jr			nz,sanity_checks_passed

				cp			(iy+t5)
				jr			nz,sanity_checks_passed

				cp			(iy+t4)
				jr			nz,sanity_checks_passed

				# The top 32 bits of the dividend were zero,
				# so we need to compare the divisor and dividend
				# directly. Subtract the divisor from the dividend.
				# 
				# The most significant bit of the subtraction result 
				# is tested. If it is set, then the result is negative, 
				# and thus dividend < divisor.

				ld			a,(iy+t0)
				sub			(iy+b0)

				ld			a,(iy+t1)
				sbc			a,(iy+b1)

				ld			a,(iy+t2)
				sbc			a,(iy+b2)

				ld			a,(iy+t3)
				sbc			a,(iy+b3)

				# Is the most significant bit of the result zero?
				bit			7,a
				jr			z,sanity_checks_passed

				# No, the result is negative. dividend < divisor.
				# So quotient = 0, remainder = dividend.

				# Copy dividend to remainder. (Clearly, if dividend < divisor,
				# then dividend will fit in 32 bits of space).
				ld			a,(iy+t3)
				ld			(iy+r3),a

				ld			a,(iy+t2)
				ld			(iy+r2),a

				ld			a,(iy+t1)
				ld			(iy+r1),a

				ld			a,(iy+t0)
				ld			(iy+r0),a

				# and leave the function early.
				jp			exit_function

sanity_checks_passed:
				# Compute an initial value for the remainder
				# and the dividend. The dividend is changed in
				# the parameter area of the stack, but this is
				# not a problem, since that area of the stack
				# is overwritten with the result of the division
				# anyway.

				ld			b,64		# b = bits counter.
computing_initial_values:
				call		lightweight_remainder_shift_left

				# Copy the 64th bit of the dividend to the 1st bit
				# of the remainder. The 1st bit of the remainder
				# is zero at present due to the left shift.

				bit			7,(iy+t7)	# 64th bit of dividend
				jr			z,initial_skip_set
				set			0,(iy+r0)	# 1st bit of remainder

initial_skip_set:		
				# Is the remainder >= the divisor?
				# To test this, calculate remainder - divisor.
				# If the result is positive, then remainder >= divisor.

				ld			a,(iy+r0)
				sub			(iy+b0)

				ld			a,(iy+r1)
				sbc			a,(iy+b1)

				ld			a,(iy+r2)
				sbc			a,(iy+b2)

				ld			a,(iy+r3)
				sbc			a,(iy+b3)

				# Is the most significant bit of the result zero?
				# If so, remainder >= divisor.
				bit			7,a
				jr			z,done_computing_initial_values

				# Shift the dividend left once.
				call		lightweight_dividend_shift_left

				# Decrease bit counter
				dec			b
				
				jr			computing_initial_values


done_computing_initial_values:

				# At present, the remainder is shifted left one
				# more space than it should be. Shift it back
				# before starting the division loop.
				call		lightweight_remainder_shift_right


				# Now, begin the division proper.
division_loop:	
				call		lightweight_remainder_shift_left
				# Copy the 64th bit of the dividend to the 1st bit
				# of the remainder. 

				bit			7,(iy+t7)	# 64th bit of dividend
				jr			z,proper_skip_set
				set			0,(iy+r0)	# 1st bit of remainder

proper_skip_set:
				# Shift the dividend left once.
				call		lightweight_dividend_shift_left

				# Shift the quotient left once.
				call		lightweight_quotient_shift_left
                
				# Calculate remainder - divisor and store
                # the result in HL and DE. (high part: HL)
                # Don't use subtract_32bits, because we want
                # to avoid the overhead of loading the numbers
                # onto the stack.

				ld			a,(iy+r0)
				sub			(iy+b0)
                ld          e,a

				ld			a,(iy+r1)
				sbc			a,(iy+b1)
                ld          d,a

				ld			a,(iy+r2)
				sbc			a,(iy+b2)
                ld          l,a

				ld			a,(iy+r3)
				sbc			a,(iy+b3)
                ld          h,a

				# Now HLDE = remainder - divisor

				# Test the 32nd bit of HLDE (8th bit of H)
				bit			7,h
				jr			nz,hlde_not_negative

				# Set the 1st bit of the quotient
				set			0,(iy+q0)

				# Set remainder = HLDE.
				ld			(iy+r3),h
				ld			(iy+r2),l
				ld			(iy+r1),d
				ld			(iy+r0),e

hlde_not_negative:
				# Go back to division_loop unless the bit counter
				# (in B) has reached zero.
				djnz		division_loop

exit_function:	
				# Ok, we're done. Quotient and Remainder hold
				# the correct values. Either the division was carried
				# out successfully, or the sanity checks found that
				# the dividend <= the divisor.


				# Free up the temporary stack space..
				pop			bc		# remove divisor and dividend
				pop			bc
				pop			bc	
				pop			bc
				pop			bc	
				pop			bc

				pop			bc		# quotient, low byte
				ld			(ix+0),c
				ld			(ix+1),b
				pop			bc
				ld			(ix+2),c
				ld			(ix+3),b
				pop			bc
				ld			(ix+4),c
				ld			(ix+5),b
				pop			bc		# quotient, high byte
				ld			(ix+6),c
				ld			(ix+7),b
				pop			bc		# remainder, low bytes
				ld			(ix+8),c
				ld			(ix+9),b
				pop			bc		# remainder, high bytes
				ld			(ix+10),c
				ld			(ix+11),b

				# Restore registers and finish.

				pop			iy
				pop			hl
				pop			de
				pop			bc
				pop			af
				pop			ix
				ret

divide_by_zero_error:
				# When a divide by zero error occurs, we print
				# an error message..
				ld			bc,divide_by_zero_error_string
				push		bc
				call		transmit_string
				pop			bc

				# .. and generate a trap. The trap procedure
				# does not return.
				call		trap_interrupt

negative_input_error:
				# When a negative input error occurs, an error
				# message is printed...
				ld			bc,negative_input_error_string
				push		bc
				call		transmit_string
				pop			bc

				# .. and a trap is generated.
				call		trap_interrupt
				
divide_by_zero_error_string:
				"\r\nError: Divide by zero attempted.\r\n\0"

negative_input_error_string:
				"\r\nError: Divide function cannot "
				"cope with negative inputs.\r\n\0"
			

# lightweight_<variable>_shift_<direction>: These lightweight 
# subroutines do a left or right shift on the appropriate 
# variable which is stored in the local variable space 
# in divide_64bits's stack.
# The carry flag is destroyed by these subroutines.
lightweight_remainder_shift_left:
				sla			(iy+r0)
				rl			(iy+r1)
				rl			(iy+r2)
				rl			(iy+r3)
				ret

lightweight_remainder_shift_right:
				srl			(iy+r3)
				rr			(iy+r2)
				rr			(iy+r1)
				rr			(iy+r0)
				ret
				
lightweight_dividend_shift_left:
				sla			(iy+t0)
				rl			(iy+t1)
				rl			(iy+t2)
				rl			(iy+t3)
				rl			(iy+t4)
				rl			(iy+t5)
				rl			(iy+t6)
				rl			(iy+t7)
				ret

lightweight_quotient_shift_left:
				sla			(iy+q0)
				rl			(iy+q1)
				rl			(iy+q2)
				rl			(iy+q3)
				rl			(iy+q4)
				rl			(iy+q5)
				rl			(iy+q6)
				rl			(iy+q7)
				ret

