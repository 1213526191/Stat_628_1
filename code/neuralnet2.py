from myFun import *
import scipy.io.arff as sparff
import random
np.random.seed(100)
# load data

nEpochs = 100
fname_train = 'train.arff'
fname_test = 'test.arff'
rate = float(sys.argv[1])/2500.

nHidden = 0
# pdb.set_trace()
X_train, Y_train, feature_mean, feature_std = loadData(fname_train, True)
# pdb.set_trace()
X_test, Y_test, _, _ = loadData(fname_test, False, feature_mean, feature_std)    
# pdb.set_trace()
weights = trainModel(X_train, Y_train, nHidden, rate, nEpochs)
# pdb.set_trace()
predict, mse = testModel(X_test, Y_test, weights, False)
# pdb.set_trace()
print(mse)

#0.03




