cd ~/public_html/wise-h/src
echo " ### Compiling the wise compiler..."
make clean && make
echo " ### generating HTML ..."
~/public_html/wise-h/bin/wise ~/public_html/wise-h/test/$2 -t
echo " ### Executing the test..."
echo vi syn.test.html
cd ~/public_html/wise-h/test
