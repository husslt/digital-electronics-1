print('| Dec |   Bin  | Char |  Code |')
print('-------------------------------')
for n, line in enumerate(open('morse.txt')):
    if line.strip() == '':
        continue
    print(f'| {n+1:3} | {n+1:06b} |   {line[0]}  | {line[1:-1]:5} |')