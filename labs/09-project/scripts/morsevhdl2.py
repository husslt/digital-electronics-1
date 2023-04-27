for i, l in enumerate(open('morse.txt')):
    if len(l.strip()) < 1:
        continue
    z = ''
    for c in l[1:].strip():
        z += '10' if c == '.' else '1110'
    z += '0'*(22-len(z))
    print(f'when "{z}" =>\n    bin <= "{i+1:06b}"; -- {l[0]}')
