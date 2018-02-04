import sys
import numpy as np
import scipy.io.arff as sparff
import pdb
import matplotlib.pyplot as plt
import random


def loadDataName():
    rate = float(sys.argv[1])
    nHidden = int(str(sys.argv[2]))
    nEpochs = int(str(sys.argv[3]))
    fname_train = str(sys.argv[4])
    fname_test = str(sys.argv[5])
    return rate, nHidden, nEpochs, fname_train, fname_test

def loadData(dataName, isTrain, feature_mean = np.NAN, feature_std = np.NAN, NArate = 0):
    data, metadata = sparff.loadarff(dataName)
    if isTrain:
        data, feature_mean, feature_std = normalize(data, metadata, isTrain)
    else:
        data, _, _ = normalize(data, metadata, isTrain, feature_mean, feature_std)

    nFeature = len(metadata.names()) - 1
    nInstance = len(data)
    X, Y = [], []
    for i in range(nInstance):
        Y.append(data[i][-1])
        XX = []

        for j in range(nFeature):
            feature_type = metadata[metadata.names()[j]]
            if feature_type[0] == 'numeric':
                XX.append(data[i][j])
            elif feature_type[0] == 'nominal':
                XXX = np.zeros(len(feature_type[1]),)
                XXX[feature_type[1].index(data[i][j])] = 1
                XX.extend(XXX)
            else:
                raise ValueError('Unrecognizable feature type.\n')
        XX.append(1)
        X.append(XX)
    return X, Y, feature_mean, feature_std



def normalize(data, metadata, isTrain, feature_mean = np.NAN, feature_std = np.NAN):
    nFeature = len(metadata.names()) - 1
    nInstance = len(data)
    if isTrain:
        feature_mean, feature_std = np.empty(nFeature, ), np.empty(nFeature, )
        feature_mean[:], feature_std[:] = np.NAN, np.NAN
    for i in range(nFeature):
        feature_type = metadata[metadata.names()[i]][0]
        if(feature_type == 'numeric'):
            if isTrain:
                XX = np.zeros(nInstance)
                for j in range(nInstance):
                    XX[j] = data[j][i]
                feature_mean[i] = np.mean(XX)
                feature_std[i] = np.std(XX)
            for j in range(nInstance):
                data[j][i] = 1.0*(data[j][i] - feature_mean[i])/feature_std[i]
    return data, feature_mean, feature_std



def setWeight(nFeature, nHidden):
    # pdb.set_trace()
    weights = []
    if(nHidden == 0):
        weights.append(np.random.uniform(weight_lb, weight_up, nFeature))
    else:
        weights.append(np.random.uniform(weight_lb, weight_up, (nHidden, nFeature)))
        weights.append(np.random.uniform(weight_lb, weight_up, nHidden))
    return weights

def sigmoid(input):
    return input
    # return np.divide(50.0,(np.add(1.0,np.exp(-input))))


def deltaLearn(X, Y, rate, weights):
    orders = np.random.permutation(len(Y))
    count = 0
    for i in orders:
        Input = np.array(X[i])
        output = sigmoid(np.dot(Input, weights[0]))
        delta = Y[i] - output
        weights_delta = np.multiply(delta, Input)
        # weights_delta = np.multiply(delta, Input)*output*(1 - output/50.0)
        weights[0] += rate*weights_delta
    return weights

def backprop(X, Y, rate, weights):
    orders = np.random.permutation(len(Y))
    count = 0
    for i in orders:
        # pdb.set_trace()
        Input = np.array(X[i])
        output1 = sigmoid(np.dot(weights[0], Input))
        output2 = sigmoid(np.dot(output1, weights[1]))
        delta2 = Y[i] - output2
        # delta1 = delta2*weights[1]*output1*(1 - output1)
        delta1 = delta2*weights[1]
        gre1 = np.outer(delta1, Input)
        gre2 = delta2*output1
        weights[0] += rate*gre1
        weights[1] += rate*gre2

    return weights 

def trainModel(X, Y, nHidden, rate, nEpochs):
    weights = setWeight(len(X[0]), nHidden)
    for i in range(nEpochs):
        if(nHidden == 0):
            weights = deltaLearn(X, Y, rate, weights)
        else:
            # pdb.set_trace()
            weights = backprop(X, Y, rate, weights)
        # print ('%d\t%d\t%d' % (i, count, len(Y) - count))
    return weights


def nn_predict(weights, rawInput):
    if len(weights) == 1:
        output = sigmoid(np.dot(rawInput, weights[0]))
    elif len(weights) == 2:
        hiddenAct = sigmoid(np.dot(weights[0], rawInput))
        output = sigmoid(np.dot(hiddenAct, weights[1]))
    else:
        raise ValueError('Unrecognizable weight cardinality.\n')
    return output  

def testModel(X, Y, weights, show = True):
    predict = []
    counts = 0
    mse = 0
    for index, instance in enumerate(X):
        output = nn_predict(weights, instance)
        # pdb.set_trace()
        mse += (output - Y[index])**2
        predict.append(output)
        if show:
            print('%2f\t%.4f\t%.4f\t\t' % (index+1, Y[index], output))
    mse = mse/len(Y)
    if show:
        print('mse: ', mse)
    # print(accuracy) 
    return predict, mse







####----run----####

weight_lb = -1
weight_up = 1
rate = 0.1
THRESHOLD = 0.5
if __name__ == '__main__':
    rate, nHidden, nEpochs, fname_train, fname_test = loadDataName()  
    X, Y, feature_mean, feature_std = loadData(fname_train, True)
    X_train, Y_train, feature_mean, feature_std = loadData(fname_train, True)
    X_test, Y_test, _,_ = loadData(fname_test, False, feature_mean, feature_std)

    # train the model
    weights = trainModel(X_train, Y_train, nHidden, rate, nEpochs)
    # evalute on the test set
    # TP, TN, FP, FN, _ = testModel(X_test, Y_test, weights)


