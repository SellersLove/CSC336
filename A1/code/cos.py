import math
def cos():
    i = 0
    for m in range(21):
        x =2*pow(10, m)
        print("m="+ str(m)+ ": " + "2*m*pi = "+ str(x*math.pi))
        print(math.cos(x*math.pi))
