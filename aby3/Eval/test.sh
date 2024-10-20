# compile the main.
cp ./frontend/main.test ./frontend/main.cpp
python build.py

# clean debugging files party-*.txt if exist.
for pfile in ./party-*.txt; do
    rm ${pfile};
done

# # synchronize with others
scp ./out/build/linux/frontend/frontend aby31:~/aby3/out/build/linux/frontend/ &
scp ./out/build/linux/frontend/frontend aby32:~/aby3/out/build/linux/frontend/ &
wait;

# run the tests
# current tests: 
# 1) -Bool : boolean share tests; 
# 2) -Arith : arithmetic share tests; 
# 3) -ORAM : ORAM tests; 
# 4) -Init : initialization tests, including the correlated shares; 
# 5) -Shuffle : secure shuffling tests.
# 6) -Graph : basic graph loading tests.
# 7) -GraphQuery : basic graph query tests (block fetching, edge exist & outting edges count.)
# 8) -Comm : test inter-party communication.
# 9) -Sort : test the sort functions.
# test_args=" -ORAM -Graph"
# test_args=" -Graph -GraphQuery -Sort"
# test_args=" -Sort -GraphQuery"
# test_args=" -GraphQuery"
# test_args=" -Bool -Comm -Graph -GraphQuery"
# test_args=" -Comm -Bool -Graph -GraphQuery"
test_args=" -Shuffle"
./Eval/dis_exec.sh "${test_args}"
wait;

# scp aby31:~/aby3/debug.txt ./debug-p1.txt
# scp aby32:~/aby3/debug.txt ./debug-p2.txt

cat ./debug.txt
rm ./debug.txt
