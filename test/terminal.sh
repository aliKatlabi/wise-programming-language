cd ..
cd /src
echo " ### Compiling the wise compiler..."
make clean && make
echo " ### generating HTML ..."
if [ -f "$file_" ];then
	rm "$file_";
	echo "$file_"
fi
cd ..

for file in /test/tests/*
do
	cd ..
  ~/bin/wise "$file" -vis on >>  ~/test/testall.test.html
done


echo " ### Executing the test..."
