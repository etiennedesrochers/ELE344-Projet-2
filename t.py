import sys

# Register file
registers = [0] * 32

# Load the input assembly code
assembly_code = """
main:   addi $3, $0, 1                                        
        add  $5, $0, $3
        sub  $7, $5, $3   
        addi $4, $3, 4   
        and  $2, $3, $4   
        or   $5, $2, $7 
To:     beq  $7, $3, next
        slt  $2, $4, $5    
        sw   $4, 8151($4)  
        lw   $2, 8155($5)
        addi $7, $2, -4 
        j    To     
next:   slt  $4, $7, $2
        and  $2, $7, $3 
        lw   $7, 8155($2)                 
        sw   $5, 8195($2)         
        beq  $5, $7, end  
        or   $7, $5, $3  
end:    lw  $4, 8195($7)
        j    main	20030001
"""

# Translate the assembly code to Python
def translate_assembly_to_python(assembly_code):
    lines = assembly_code.strip().split('\n')
    python_code = []

    for line in lines:
        parts = line.strip().split()
        if parts:
            instruction = parts[0]
            if instruction == 'addi':
                reg1 = int(parts[1][1:])
                reg2 = int(parts[2][1:])
                imm = int(parts[3])
                registers[reg1] = registers[reg2] + imm
            elif instruction == 'add':
                reg1 = int(parts[1][1:])
                reg2 = int(parts[2][1:])
                reg3 = int(parts[3][1:])
                registers[reg1] = registers[reg2] + registers[reg3]
            elif instruction == 'sub':
                reg1 = int(parts[1][1:])
                reg2 = int(parts[2][1:])
                reg3 = int(parts[3][1:])
                registers[reg1] = registers[reg2] - registers[reg3]
            elif instruction == 'and':
                reg1 = int(parts[1][1:])
                reg2 = int(parts[2][1:])
                reg3 = int(parts[3][1:])
                registers[reg1] = registers[reg2] & registers[reg3]
            elif instruction == 'or':
                reg1 = int(parts[1][1:])
                reg2 = int(parts[2][1:])
                reg3 = int(parts[3][1:])
                registers[reg1] = registers[reg2] | registers[reg3]
            elif instruction == 'beq':
                reg1 = int(parts[1][1:])
                reg2 = int(parts[2][1:])
                label = parts[3]
                if registers[reg1] == registers[reg2]:
                    python_code.append(f"goto {label}")
            elif instruction == 'slt':
                reg1 = int(parts[1][1:])
                reg2 = int(parts[2][1:])
                reg3 = int(parts[3][1:])
                registers[reg1] = 1 if registers[reg2] < registers[reg3] else 0
            elif instruction == 'sw':
                reg1 = int(parts[1][1:])
                address = registers[int(parts[2][1:-1])] + int(parts[2][-1])
                # Simulate memory access
                sys.stdout.write(f"Storing value {registers[reg1]} at address {address}\n")
            elif instruction == 'lw':
                reg1 = int(parts[1][1:])
                address = registers[int(parts[2][1:-1])] + int(parts[2][-1])
                # Simulate memory access
                registers[reg1] = 0  # Assuming the value at the address is 0
                sys.stdout.write(f"Loading value {registers[reg1]} from address {address}\n")
            elif instruction == 'j':
                label = parts[1]
                python_code.append(f"goto {label}")
            else:
                raise ValueError(f"Unsupported instruction: {instruction}")

    return '\n'.join(python_code)

# Translate the assembly code to Python
python_code = translate_assembly_to_python(assembly_code)
print(python_code)

