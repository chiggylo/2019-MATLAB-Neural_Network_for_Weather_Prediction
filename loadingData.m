% loading data
[inputData,inputText,inputRaw] = xlsread('nn daily 6-input.xlsx');
[targetData,targetText,targetRaw] = xlsread('nn daily 4-output.xlsx');
[testingData, testingText, testingRaw] = xlsread('nn daily 6-testing.xlsx');
[actualData, actualText, actualRaw] = xlsread('nn daily actual.xlsx');