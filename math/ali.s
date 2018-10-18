# ali.s: Abstracted Linear Interpolator
# Used by both the sine and arctangent functions, the ALI code is able to turn
# a value in the range 0.0 to 1.0 to the best value from a translation table.
# It does this by locating the values in the table that most closely match
# the required one, and using linear interpolation to estimate the value
# of the function. Fixed point numbers are used for both the input and output.
#
# Restrictions: The ALI works with tables of a fixed length, defined in the 
# constants section. Furthermore, no checking is done to ensure that the
# input is in the range 0.0 to 1.0 - the caller must ensure this, or results
# are undefined.
# The table should be table_length + 1 rows in length.
# The first row (0) should be the value for 0.0.
# The last row (1024) should be the value for 1.0.

# Global procedures and functions defined in this file:
.globl ali

# Global procedures and functions used by this file:
.globl subtract_fp
.globl multiply_fp
.globl add_fp
.globl lightweight_marshall_parameters_arity_1

# Constants used in this file:
table_length = 1024
table_length_bits = 10


# ali: Abstracted Linear Interpolator
# 
# This function follows the standard fixed point number function calling 
# convention for arity 1 functions: see fixed_point.s for details. The one
# addition is that the caller must push a pointer to the start of the
# table before pushing the variable area pointer or the index.
# Usage:
#           push <table start offset>
#           push <ptr to start of variable area>
#           push <index of input/output fixed point number>0
#           call ali
#           pop <index of input/output fixed point number>0
#           pop <ptr to start of variable area>
#           pop <table start offset>
ali:        
				# Set up the stack...
				push		ix
				ld			ix,0x0000
				add			ix,sp

				# Store register values
				push		af
				push		bc
				push		de
				push		hl
				push		iy

                # Save IX
                push        ix

                # Get input value pointer into IX:
                call        lightweight_marshall_parameters_arity_1

                # move it to IY..
                push        ix
                pop         iy

                # restore original IX
                pop         ix

                # Special case checking: is input value 1?
                ld          a,0
                cp          (iy+3)
                jr          z,input_is_less_than_1

                # Return value for 1: the end of the table.

                # Load table start pointer into BC.
                ld          c,(ix+8)
                ld          b,(ix+9)
                ld          ix,table_length * 4
                add         ix,bc       # Make IX point to the last table row

                ld          a,(ix+0)
                ld          (iy+0),a
                ld          a,(ix+1)
                ld          (iy+1),a
                ld          a,(ix+2)
                ld          (iy+2),a
                ld          a,(ix+3)
                ld          (iy+3),a

                jp          finished        # Go to the end of the function

input_is_less_than_1:
                # The high 8 bits of the fixed point input number are zero.
                # The next highest <table_length_bits> bits of the input number
                # select the row of the table that we're going to start from.
                # Extract those bits now.

                ld          d,(iy+2)        # copy the bits into DE
                ld          e,(iy+1)

                # Now shift them right some number of times
                # so that DE = the number of the table row.

                ld          b,16 - table_length_bits
shift_right_loop:
                srl         d
                rr          e
                djnz        shift_right_loop

                # DE = number of the table row. Convert DE to a
                # table offset by multiplying by 4 (each row is bytes long).
                # This is a double left shift.
                sla         e
                rl          d
                sla         e
                rl          d

                # Load table start pointer into HL.
                ld          c,(ix+8)
                ld          b,(ix+9)
                # and copy it to IX:
                ld          ix,0
                add         ix,bc
                add         ix,de       # Make IX point to the row in memory
                
                # The final bits from the input number are termed the
                # interpolation value. Shift them left so that the
                # interpolation value becomes a fixed point number from
                # 0.0 to 1.0. This is a shift through <table_length_bits>.

                ld          b,table_length_bits
shift_left_loop:
                sla         (iy+0)
                rl          (iy+1)
                rl          (iy+2)
                djnz        shift_left_loop

                # Now we copy the interpolation value (at IY) onto the stack
                # so we can subtract it from 1.

                ld          bc,0x0100       # put 1 on the stack
                push        bc
                ld          b,0             # put zero on the stack
                push        bc

                ld          b,(iy+3)
                ld          c,(iy+2)
                push        bc
                ld          b,(iy+1)
                ld          c,(iy+0)
                push        bc

                # Calculate 1 - the interpolation value.
                ld          hl,0
                add         hl,sp       # Make HL point to 
                                        # interpolation value on stack
                push        hl
                ld          bc,0x0100   # subtract interpolation value
                                        # (index 0) from one (index 1).
                push        bc
                call        subtract_fp
                pop         bc
                pop         hl

                # Now, HL points to a variable area containing
                # index 0: interpolation value.
                # index 1: 1 - interpolation value.

                # Now copy the value from the table (at IX) onto the stack.
                ld          b,(ix+3)
                ld          c,(ix+2)
                push        bc
                ld          b,(ix+1)
                ld          c,(ix+0)
                push        bc

				# and the value after it (at IX+4)
                ld          b,(ix+7)
                ld          c,(ix+6)
                push        bc
                ld          b,(ix+5)
                ld          c,(ix+4)
                push        bc

                # Multiply the table value and 1 - interpolation value,
                # by copying the pointer to their area of memory into HL:
                ld          hl,0
                add         hl,sp
                push        hl             # base of variable area.
                ld          bc,0x0301      # multiply numbers at index 1
                                           # and index 3 - store result
                                           # at index 3.
                push        bc
                call        multiply_fp
                pop         bc

                # Multiply the table value and original interpolation value.
                ld          bc,0x0200      # multiply numbers at index 0
                                           # and index 2 - store result
                                           # at index 2.
                push        bc
                call        multiply_fp
                pop         bc

                # Add the numbers at index 2 and index 3, storing
                # the result at index 3.
                ld          bc,0x0302
                push        bc
                call        add_fp
                pop         bc

                pop         hl

                # Free the space allocated on the stack. The resulting
                # interpolated value is the last 4 bytes allocated.
                pop         hl          # 6 pops = free 12 bytes.
                pop         hl
                pop         hl
                pop         hl
                pop         hl
                pop         hl

                # Now, the next 4 bytes contain the interpolated value.
                # Copy it to IY in order to return it.
                pop         hl
                ld          (iy+0),l
                ld          (iy+1),h
                pop         hl
                ld          (iy+2),l
                ld          (iy+3),h

finished:                
                # Restore register values
                pop         iy
                pop         hl
                pop         de
                pop         bc
                pop         af
                pop         ix
                ret
                
