
homedir=$(pwd)

cd $homedir/src/
echo " ### Compiling the wise compiler..."
make --ignore-errors clean && make
echo " ### generating HTML ..."
if [ -f "$file_" ];then
	rm "$file_";
	echo "$file_"
fi


for file in $homedir/test/tests/*
do
  $homedir/src/wise "$file" -vis on >>  $homedir/test/testall.test.html
done


echo " ### Executing the test..."

