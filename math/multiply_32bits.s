# multiply_32bits.s: This file contains a 32 bit multiplier.

# Global procedures and functions defined in this file:
.globl multiply_32bits


# multiply_32bits: multiply two 32 bit numbers together.
# The function must be passed a single pointer which points to two
# 32 bit words next to each other in memory. These two words are
# multiplied together and the result is stored in the same place.
# The numbers are assumed to be unsigned.
#
# In memory:
#   before multiply_32bits runs, word_ptr points to 'aaaabbbb'
#         aaaa - first 32 bit word    bbbb - second 32 bit word
#   after multiply_32bits runs, word_ptr points to 'rrrrrrrr'
#         rrrrrrrr - result 64 bit word
# 
# Usage:
#       push word_ptr
#       call multiply_32bits
#       pop
#
multiply_32bits:
		
				# Set up the stack...
				push		ix
				ld			ix,0
				add			ix,sp

				# Store values of registers we intend to use.
				push		af
				push		bc
				push		de
				push		iy

                # Copy the parameter into IX. IX will then point to
                # the area of memory where the two words are. 
                ld          b,(ix+5)    # load address of number into BC
                ld          c,(ix+4)
                ld          ix,0        # copy BC to IX
                add         ix,bc

				# Least signicant byte of first 32 bit word: (ix+0)
				# Most signicant byte of first 32 bit word: (ix+3)
				# First 32 bit word: a3 a2 a1 a0
				# Least signicant byte of second 32 bit word: (ix+4)
				# Most signicant byte of second 32 bit word: (ix+7)
				# Second 32 bit word: b3 b2 b1 b0

				# The following constants are used for fast access
				# to the bytes of the input values:
						b3 = 7
						b2 = 6 
						b1 = 5
						b0 = 4
						a3 = 3
						a2 = 2
						a1 = 1
						a0 = 0

				# During the runtime of this function we will be using
				# a 64 bit accumulator variable on the stack. Add a
				# 64 bit value (4x16 bit words) to the stack with
				# initial value 0.
				ld			iy,0
				push		iy
				push		iy
				push		iy
				push		iy
				add			iy,sp		# Set IY to point to this accumulator

				# Least significant byte of accumulator: (iy+0)
				# Most significant byte of accumulator: (iy+7)

				# Multiply a0*b0, no shift
				ld			b,(ix+a0)
				ld			c,(ix+b0)
				ld			a,0
				call		lightweight_multiply_shift_add

				# Multiply a1*b0, shift by 1 byte
				ld			b,(ix+a1)
				ld			c,(ix+b0)
				ld			a,1
				call		lightweight_multiply_shift_add

				# Multiply a0*b1, shift by 1 byte
				ld			b,(ix+a0)
				ld			c,(ix+b1)
				ld			a,1
				call		lightweight_multiply_shift_add

				# Multiply a2*b0, shift by 2 bytes
				ld			b,(ix+a2)
				ld			c,(ix+b0)
				ld			a,2
				call		lightweight_multiply_shift_add

				# Multiply a1*b1, shift by 2 bytes
				ld			b,(ix+a1)
				ld			c,(ix+b1)
				ld			a,2
				call		lightweight_multiply_shift_add

				# Multiply a0*b2, shift by 2 bytes
				ld			b,(ix+a0)
				ld			c,(ix+b2)
				ld			a,2
				call		lightweight_multiply_shift_add

				# Multiply a3*b0, shift by 3 bytes
				ld			b,(ix+a3)
				ld			c,(ix+b0)
				ld			a,3
				call		lightweight_multiply_shift_add

				# Multiply a2*b1, shift by 3 bytes
				ld			b,(ix+a2)
				ld			c,(ix+b1)
				ld			a,3
				call		lightweight_multiply_shift_add

				# Multiply a1*b2, shift by 3 bytes
				ld			b,(ix+a1)
				ld			c,(ix+b2)
				ld			a,3
				call		lightweight_multiply_shift_add

				# Multiply a0*b3, shift by 3 bytes
				ld			b,(ix+a0)
				ld			c,(ix+b3)
				ld			a,3
				call		lightweight_multiply_shift_add

				# Multiply a3*b1, shift by 4 bytes
				ld			b,(ix+a3)
				ld			c,(ix+b1)
				ld			a,4
				call		lightweight_multiply_shift_add

				# Multiply a2*b2, shift by 4 bytes
				ld			b,(ix+a2)
				ld			c,(ix+b2)
				ld			a,4
				call		lightweight_multiply_shift_add

				# Multiply a1*b3, shift by 4 bytes
				ld			b,(ix+a1)
				ld			c,(ix+b3)
				ld			a,4
				call		lightweight_multiply_shift_add

				# Multiply a3*b2, shift by 5 bytes
				ld			b,(ix+a3)
				ld			c,(ix+b2)
				ld			a,5
				call		lightweight_multiply_shift_add

				# Multiply a2*b3, shift by 5 bytes
				ld			b,(ix+a2)
				ld			c,(ix+b3)
				ld			a,5
				call		lightweight_multiply_shift_add

				# Multiply a3*b3, shift by 6 bytes
				ld			b,(ix+a3)
				ld			c,(ix+b3)
				ld			a,6
				call		lightweight_multiply_shift_add

				# Finished. (iy) now contains the output 64 bit word.
				# Need to copy it from (IY) to (IX) in order to return it.
				# Do this while freeing up the accumulator part of the stack:
				pop			bc
				ld			(ix+0),c
				ld			(ix+1),b
				pop			bc
				ld			(ix+2),c
				ld			(ix+3),b
				pop			bc
				ld			(ix+4),c
				ld			(ix+5),b
				pop			bc
				ld			(ix+6),c
				ld			(ix+7),b

				# and restore the other registers
				pop			iy
				pop			de
				pop			bc
				pop			af
				pop			ix

				# return

				ret

# lightweight_multiply_shift_add
# This lightweight (non-reusable, non-stack preserving, but fast) function:
# (1) multiplies B and C
# (2) shifts the result left by A bytes
# (3) adds the result to the 64 bit accumulator pointed to by IY.
# In actuality the last two operations are combined.

lightweight_multiply_shift_add:
				# Multiply B and C.
				mlt		bc

				# call 		lightweight_software_multiply_b_and_c

				# Use A, the shift offset, to calculate
				# where BC should be added to the 64 bit accumulator.
				ld			d,0
				ld			e,a
				push		iy		# save IY
				add			iy,de

				# IY now points to the start of the place to add BC.

				ld			a,(iy+0)	# add C to (IY+0)
				add			a,c
				ld			(iy+0),a

				ld			a,(iy+1)	# add B (with carry) to (IY+1)
				adc			a,b
				ld			(iy+1),a

				# Is the carry flag set? If so, we must go through
				# at least some of the higher bytes of the accumulator,
				# adding it in.
				jr			nc,lightweight_multiply_shift_add_done

				# Carry flag is set.
				# Point IY at the digit before the one to be 
				# modified by adding 1.
				inc			iy

				# Add zero, with carry, to the rest of the accumulator.
				# First of all, how much of the accumulator is left?
				ld			a,8 - 2	# 8 bytes in accum, 2 bytes already
				sub			e		# dealt with, and E contains the offset.

				# Number of turns now in A. Copy to B.
				ld			b,a

				# SUB has destroyed the carry flag. Set it again.
				scf

				# Put the constant zero in C.
				ld			c,0

				# Add zero, with carry, to the rest of the accumulator.
				# We do this until B = 0.
lightweight_multiply_shift_add_loop:
				inc			iy

				ld			a,c		# Zero A. A = C = 0
				adc			a,(iy)	# add zero (with carry) to (IY)
				ld			(iy),a	# Store result back.

				djnz		lightweight_multiply_shift_add_loop

lightweight_multiply_shift_add_done:
				pop			iy		# restore IY's original value.

				# No need to restore b, c, a, d and e:
				# multiply_32bits expects them to be
				# destroyed by lightweight_multiply_shift_add.
				ret



				# IY now points to the start of the place to add BC.

				ld			a,(iy)	# add C to (IY)
				add			a,c
				ld			(iy),a

				inc			iy		# INC does not affect the carry flag.

				ld			a,(iy)	# add B (with carry) to (IY)
				adc			a,b
				ld			(iy),a

				inc			iy

				# Add zero, with carry, to the rest of the accumulator...
				# IF carry is non-zero:
				jr			nc,lightweight_multiply_shift_add_done

				# First of all, how much of the accumulator is left?
				ld			a,8 - 2	# 8 bytes in accum, 2 bytes already
				sub			e		# dealt with, and E contains the offset.

				# Number of turns now in A. Copy to B.
				ld			b,a

				# Add zero, with carry, to the rest of the accumulator.
				# We do this until B = 0.

#lightweight_multiply_shift_add_loop:
				xor			a		# Zero A.
				adc			a,(iy)	# add zero (with carry) to (IY)
				ld			(iy),a	# Store result back.

				inc			iy
				djnz		lightweight_multiply_shift_add_loop

#lightweight_multiply_shift_add_done:
				pop			iy		# restore IY's original value.

				# No need to restore b, c, a, d and e:
				# multiply_32bits expects them to be
				# destroyed by lightweight_multiply_shift_add.
				ret



