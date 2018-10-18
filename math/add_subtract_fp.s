# add_subtract_fp.s: This file contains simple fixed point adder and subtractor
# functions. They work on fixed point numbers and follow the standard fixed
# point function calling convention (see fixed_point.s for details).
#
# Also here: negation and comparator functions for fixed point numbers.

# Global procedures and functions defined in this file:
.globl add_fp
.globl subtract_fp
.globl negate_fp
.globl compare_fp

# Global procedures and functions called in this file:
.globl lightweight_marshall_parameters_arity_1
.globl lightweight_marshall_parameters_arity_2



# add_fp: Add two fixed point numbers together and store the 
# result. This function follows the standard fixed point number
# function calling convention for arity 2 functions: see 
# fixed_point.s for details.
add_fp:
				# Stack setup...
				push		ix
				ld			ix,0
				add			ix,sp

				push		af          # Save registers
				push		bc
                push        hl
                push        iy

				call		lightweight_marshall_parameters_arity_2

                # Now IX points to the first number/result
                # and IY points to the second number
                
                # Do the addition
                ld          a,(ix+0)
                add         a,(iy+0)
				ld			c,a

                ld          a,(ix+1)
                adc         a,(iy+1)
				ld			b,a

                ld          a,(ix+2)
                adc         a,(iy+2)
				ld			l,a

                ld          a,(ix+3)
                adc         a,(iy+3)
				ld			h,a

				ld			(ix+0),c
				ld			(ix+1),b
				ld			(ix+2),l
				ld			(ix+3),h

                # restore registers.
                pop         iy
                pop         hl
                pop         bc
                pop         af
                pop         ix
                ret

# subtract_fp: Subtract one fixed point number from another.
# This function follows the standard fixed point number function
# calling convention for arity 2 functions: see fixed_point.s 
# for details.
subtract_fp:
				# Stack setup...
				push		ix
				ld			ix,0
				add			ix,sp

				push		af          # Save registers
				push		bc
				push		hl
                push        iy

				call		lightweight_marshall_parameters_arity_2

                # Now IX points to the first number/result
                # and IY points to the second number

                # Result = First Number - Second Number
                # Do the subtraction.
                ld          a,(ix+0)
                sub         (iy+0)
				ld			c,a

                ld          a,(ix+1)
                sbc         a,(iy+1)
				ld			b,a

                ld          a,(ix+2)
                sbc         a,(iy+2)
				ld			l,a

                ld          a,(ix+3)
                sbc         a,(iy+3)
				ld			h,a

				ld			(ix+0),c
				ld			(ix+1),b
				ld			(ix+2),l
				ld			(ix+3),h

                pop         iy
				pop			hl
                pop         bc
                pop         af
                pop         ix

                ret


# negate_fp: Find the negation of the input number. So 2 becomes -2.
# This function follows the standard fixed point number function
# calling convention for arity 1 functions: see fixed_point.s for details.
negate_fp:
				# Stack setup...
				push		ix
				ld			ix,0
				add			ix,sp

				push		af          # Save registers
				push		bc
				push		hl

				call		lightweight_marshall_parameters_arity_1

                # Now IX points to the number to be negated.
				# Subtract it from zero.
                ld          a,0
                sub         (ix+0)
				ld			(ix+0),a

                ld          a,0
                sbc         a,(ix+1)
				ld			(ix+1),a

                ld          a,0
                sbc         a,(ix+2)
				ld			(ix+2),a

                ld          a,0
                sbc         a,(ix+3)
				ld			(ix+3),a

				pop			hl
                pop         bc
                pop         af
                pop         ix

                ret

# compare_fp: Compare two 32 bit/fixed point numbers.
# This function follows the standard fixed point number function
# calling convention for arity 2 functions: see fixed_point.s for details.
# BUT, the pointers on the stack at call time are modified according to
# the result of the comparison.
#
# Usage:
#		push	<ptr to start of variable area>
#		push	<index of X><index of Y>
#		call	compare_fp
#		pop		af
#		pop 	<ptr to start of variable area>
# A contains the returned value in this example.
#
# If X (first) is greater than Y (second), then A = 1 is returned.
# If X (first) is equal to Y (second), then A = 0 is returned.
# If X (first) is less than Y (second), then A = -1 is returned.
#
compare_fp:
				# Stack setup...
				push		ix
				ld			ix,0
				add			ix,sp

				push		af          # Save registers
				push		bc
                push        hl
                push        iy

				push		ix			# Also save IX, so that
										# the result can be returned.

				call		lightweight_marshall_parameters_arity_2

                # Now IX points to the first number
                # and IY points to the second number

                # Calculate First Number - Second Number, just
				# like subtract_fp
                ld          a,(ix+0)
                sub         (iy+0)
                ld          b,a

                ld          a,(ix+1)
                sbc         a,(iy+1)
                ld          c,a

                ld          a,(ix+2)
                sbc         a,(iy+2)
                ld          h,a

                ld          a,(ix+3)
                sbc         a,(iy+3)
                ld          l,a

				# Is the result negative? Check the 32nd bit
				# of the result, which happens to be the 8th bit
				# of A.

				bit			7,a
				jr			nz,result_is_negative

				# Result is not negative. It is possible that all
                # the bytes are equal. If b, c, d and e are all zero,
                # then the numbers are equal.

                ld          a,b
                or          c
                or          h
                or          l

				# A contains the logical OR of all 4 bytes 
				# of the result. Is it zero?
				jr			z,result_is_zero

result_is_positive:
				# first - second > 0.
				# therefore: first > second. Return 1.
				ld			a,1
				jr			exit_compare

result_is_negative:
				# first - second < 0.
				# therefore: first < second. Return -1.
				ld			a,-1

result_is_zero:
exit_compare:	pop			ix
				ld			(ix+5),a		# Return value in A

				# Clean up and finish.
                pop         iy
				pop			hl
                pop         bc
                pop         af
                pop         ix

                ret

