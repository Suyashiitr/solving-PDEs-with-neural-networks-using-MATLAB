clc
x1 = 0.000025:0.000025:1;
x1 = x1';
t = 0.25 + zeros(40000, 1);
y1 = u(t, x1);
data = table(x1, t, y1);
trainsplit = 0.8;
valsplit = 0.1;
testsplit = 0.1;

numRows = size(data, 1);
rng(1);
cv = cvpartition(numRows, 'HoldOut', 1 - trainsplit);
trainData = data(cv.training, :);
tempData = data(cv.test, :);
tempNumRows = size(tempData, 1);
cv2 = cvpartition(tempNumRows, 'HoldOut', valsplit / (valsplit + testsplit));
valData = tempData(cv2.training, :);
testData = tempData(cv2.test, :);

net = feedforwardnet([10, 10, 10, 10, 10, 10]);

options = trainingOptions('adam', ...
    'MaxEpochs', 50, ...
    'MiniBatchSize', 64, ...
    'InitialLearnRate', 0.01, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.1, ...
    'LearnRateDropPeriod', 20, ...
    'Shuffle', 'every-epoch', ...
    'Plots', 'training-progress');

x_train = trainData{:, {'x1', 't'}};
y_train = trainData{:, 'y1'};
x_val = valData{:, {'x1', 't'}};
y_val = valData{:, 'y1'};
x_test = testData{:, {'x1', 't'}};

net = train(net, x_train', y_train',[],[],[]);

y_valPred = net(x_val');

y_pred = net(x_test');

val_loss = mse(y_val', y_valPred);

test_loss = mse(testData{:, 'y1'}', y_pred);

x_all = [x1, t];  
pred = net(x_all');
figure;
plot(x1, u(t, x1), 'LineWidth', 1.5, 'DisplayName', 'Original Function');
hold on;
plot(x1, pred, 'LineWidth', 1.5, 'LineStyle', '--', 'DisplayName', 'Predicted Values');
xlabel('x');
ylabel('y');
title('Original Function vs. Predicted Values');
legend;
grid on;


function output = u(t,x)
    output = sin(x*pi).*cos(pi*t)/2 + sin(3*pi*x).*sin(3*pi*t)/3 ;
end