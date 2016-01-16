import random
import math
from copy import deepcopy
def noGauss(A,b):
	""" Gauss elimination with no pivoting

	A: nxn matirx with form [[row(1)],[row(2)]...[row(n)]]
	b: n-vector with form [b(1),b(2)...b(n)]

	return x: the solution for the linear system eqution Ax = b.
	"""
	n = len(A)
	#iteration times
	iteration = n - 1
	for i in range(0, iteration):
		# elimination on kth row
		for k in range(i+1, n):
			m = -A[k][i]/A[i][i]
			# Set all entrys right below (in the current colnum) A[i][i] to 0
			A[k][i] = 0.0
			# update b
			b[k] += m*b[i]
			for j in range(i+1, n):
				A[k][j] += m * A[i][j]
	# Solve equation Ax=b for an upper triangular matrix A
	x = [0.0 for i in range(n)]
	for i in range(n-1, -1, -1):
		x[i] = b[i]/A[i][i]
		for k in range(i-1, -1, -1):
			b[k] -= A[k][i] * x[i]
	return x

def partialGauss(A,b):
	""" Gauss elimination with partial pivoting

	A: nxn matirx with form [[row(1)],[row(2)]...[row(n)]]
	b: n-vector with form [b(1),b(2)...b(n)]

	return x: the solution for the linear system eqution Ax = b.
	"""
	n = len(A)
	iteration = n - 1
	for i in range(0, iteration):
	# Search for maximum in this column
		pivot = abs(A[i][i])
		maxRow = i
		for k in range(i+1, n):
			if abs(A[k][i]) > pivot:
				pivot = abs(A[k][i])
				maxRow = k
		# Swap maximum row with current row
		if i != maxRow:
			A[i], A[k] = A[k], A[i]
			b[i], b[k] = b[k], b[i]
		# Set all entrys right below (in the current colnum) A[i][i] to 0
		for k in range(i+1, n):
			m = -A[k][i]/A[i][i]
			A[k][i] = 0.0
			b[k] += m*b[i]
			for j in range(i+1, n):
				A[k][j] += m * A[i][j]
	# Solve equation Ax=b for an upper triangular matrix A
	x = [0.0 for i in range(n)]
	for i in range(n-1, -1, -1):
		x[i] = b[i]/A[i][i]
		for k in range(i-1, -1, -1):
			b[k] -= A[k][i] * x[i]
	return x

def completeGauss(A,b):
	""" Gauss elimination with complete pivoting

	A: nxn matirx with form [[row(1)],[row(2)]...[row(n)]]
	b: n-vector with form [b(1),b(2)...b(n)]

	return x: the solution for the linear system eqution Ax = b.
	"""
	n = len(A)
	iteration = n - 1
	# r indicate the order of each of x(i)s
	x = [[r,0.0] for r in range(n)]
	for i in range(iteration):
	# Search for maximum in submatirx
		pivot = abs(A[i][i])
		maxRow = i
		maxCol = i
		for row in range(i, n):
			for col in range(i, n):
				if abs(A[row][col]) > pivot:
					pivot = abs(A[row][col])
					maxRow = row
					maxCol = col
		if i != maxRow or i!= maxCol:
			# Swap maximum row with current row 
			A[i], A[maxRow] = A[maxRow], A[i]
			b[i], b[maxRow] = b[maxRow], b[i]
			# swap the order of x
			x[i], x[maxCol] = x[maxCol], x[i]
			# Swap maximum col with current col for A
			for row in range(n):
				A[row][i], A[row][maxCol] = A[row][maxCol], A[row][i]
		# Set all entrys right below (in the current colnum) A[i][i] to 0
		for k in range(i+1, n):
			m = -A[k][i]/A[i][i]
			A[k][i] = 0.0
			b[k] += m*b[i]
			for j in range(i+1, n):
				A[k][j] += m * A[i][j]
	# Solve equation Ax=b for an upper triangular matrix A
	for i in range(n-1, -1, -1):
		x[i][1] = b[i]/A[i][i]
		for k in range(i-1, -1, -1):
			b[k] -= A[k][i] * x[i][1]
	# reorder x(i)s
	result = [ 0.0 for i in range(n)]
	for i in range(n):
		result[x[i][0]] = x[i][1]
	return result


def generator(n):
	A = [[random.random()*100  for i in range(n)] for j in range(n)]
	b = [0.0 for i in range(n)]
	for row in range(n):
		for col in range(n):
			b[row] = b[row] + float(pow(-1,col+2)*A[row][col])
	return A,b

def generatorV2(n):
	A = [[0.0 for i in range(n)] for j in range(n)]
	b = [0.0 for i in range(n)]
	A[0][0] = 1.0
	A[0][n-1] = 1.0
	b[0] = 1.0 + float(pow(-1,n+1)) 
	for row in range(1, n):
		A[row][0] = -1.0
		A[row][row] = 1.0
		if (n-1) == row:
			b[row] = A[row][0] + A[row][n-1]*float(pow(-1,n+1))
		else:
			A[row][n-1] = 1.0
			b[row] = A[row][0] + A[row][n-1]*float(pow(-1,n+1)) + A[row][row]*float(pow(-1,row+2))
		for col in range(1,row):
			A[row][col] = -1.0
			b[row] = b[row] + float(pow(-1,col+2)*A[row][col])
	return A,b

def testV1(n):
		A,b = generator(n)
		A1 = deepcopy(A)
		b1 = deepcopy(b)
		A2 = deepcopy(A)
		b2 = deepcopy(b)
		print "--------------------------------------------------" + str(n) + "-------------------------------------------------------------"
		print noGauss(A,b)
		print partialGauss(A1,b1)
		print completeGauss(A2,b2)

def testV2(n):
	A,b = generatorV2(n)
	print "no pivoting"
	print noGauss(A,b)
	A,b = generatorV2(n)
	print "partial pivoting"
	print partialGauss(A,b)
	A,b = generatorV2(n)
	print "complete pivoting"
	print completeGauss(A,b)


if __name__ == '__main__':
	#testV1(129)
	testV2(59)
