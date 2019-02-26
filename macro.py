mdt = [] 
mdtc = 0
mnt = {}  #dictionary with values as tuples
mntc = 0
ala = {}  #dictionary with values as list

infile = open('C:\\Users\\Pulin Shah\\source\\repos\\macro_sample.txt')
outfile = open('C:\\Users\\Pulin Shah\\source\\repos\\macro_1_op.txt',mode='w')
lines = infile.readlines()
macro_start = 0
for i in range(len(lines)):
    lines[i] = lines[i].replace('\n','')
    current_line = lines[i]
    current_line = current_line.replace(',',' ').split()
    if 'MACRO' in current_line:
        macro_start = 1
    elif macro_start == 1:  #process nameline
        mdt.append(lines[i])
        label = 0
        if '&' in current_line[0]:  #it is label
            mnt[mntc] = (current_line[1],mdtc)
            label = 1
        else:
            mnt[mntc] = (current_line[0],mdtc)
        ala_list = []
        for item in range(len(current_line)):
            if label == 1 and item == 0:
                ala_list.append(current_line[item])
            elif label == 0 and item == 0:
                ala_list.append('-')
            else: 
                ala_list.append(current_line[item])
        macro_start = 2
        ala[mntc] = ala_list
        mntc+=1
        mdtc+=1
    elif macro_start == 2:   #process remaining defn
        for index,item in enumerate(ala[mntc-1]):
            if item in lines[i]:
                print(item)
                lines[i] = lines[i].replace(item,'#'+str(index))
        mdt.append(lines[i])
        if 'MEND' in lines[i]:
            macro_start = 0
        mdtc+=1
    else:
        outfile.write(lines[i] + '\n')
outfile.close()
print(mdt)
print(mnt)
print(ala)



