
		
# lightweight_software_multiply_b_and_c
# Multiply b and c together, store the result in bc.
# This is the same as the H180 instruction 'mlt bc' but slower.
# All other registers are preserved.
lightweight_software_multiply_b_and_c:
				push		af
				push		de
				push		hl

				ld			a,1		# COUNTER 0 - 7

				ld			hl,0	# OUTPUT

				ld			d,0		# SHIFTER
				ld			e,c		

mlt_loop:		push		af
				and			b
				cp			0
				jr			z,skip_add

				add			hl,de

skip_add:		pop			af
				or			a
				rl			e
				rl			d

				or			a
				rl			a

				cp			0
				jr			nz,mlt_loop

				ld			b,h
				ld			c,l
				pop			hl
				pop			de
				pop			af

				ret







