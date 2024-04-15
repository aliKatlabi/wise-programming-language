# Wise H

# Wise H
Wise-H Language is a scripting language made to generate a properly structured and syntactically checked HTML document from a shorter and more concise HTML based language. 
It shall be designed to be more readable than HTML and will reduce redundancy of HTML tags. Also, it shall enhance visual skimming of the code, make it easier for editing, and should guarantee a better use of the code space.

# What is Wise-H and this page ?
Wise-H Language is a scripting language,where it tries to reduce the HMTL redondance code, giving to the programmers a wise way of coding. This page is here to guide future Wise-H developers and/or contributors to get the first steps. Here you will learn how to use the language in your own machine and make your first program.


# Building Wise-H from source
It is advised if you want to evaluate a stable system, clone our repository from  github. 
Still, if you want to build the current version from source, make sure you have the following tools:

1. bisonc++ V4.01.00
2. flex 2.5.35
3. gcc 4.7.2

Please make sure that you have the exactly same version of each tool, we can not guarantee that may work on different version since we never tried before.
Check your versions using bison --version, flex --version and gcc version commands. Once you have cloned the repository, 
Then cd to the codebase (folder wise-h) and use the following commands:

# how to get wise ?

you can clone the source code from the repository 
```bash
git clone https://gitlab.com/aliKatlabi/wise-h.git
```
or get the artifacts using 
```
wget http://wisehproject.eastus.cloudapp.azure.com/job/wise_final/lastSuccessfulBuild/artifact/*zip*/archive.zip
```
or
```
curl -LO http://wisehproject.eastus.cloudapp.azure.com/job/wise_final/lastSuccessfulBuild/artifact/*zip*/archive.zip
```
To build the system after you have the source code:
```bash
make
```
To build the system, clean:
```bash
make clean
```
Or use the build script
```bash
sh build/build.sh
```

To run your fist code :

after you construct a code name the file as example.wise 

using the terminal 

```
bin\wise 		'wisefile_path' > 'outHTML_path' -vis (on|off) 
bin\wise 		-t  for terminal typing (interpreter)
bin\wise 		-t -vis (on|off)

```
** -vis on|off : turn on and off lexical and syntactical analysis

** -t          : the interpreter is still experimental 


# Wise syntax 

#### general rules 

Text area is a string inside apostrophes ' text ' 
* can be used to represent attributes
* cab be use to wrire html elements contnet  

The language syntax is sensitive to whitspaces.
* lines is used to represent the following element in a block
* and can be between blocks with no effect 
* indents on the other hand is only used in the block context and a text area and never tolerated outside 
* spaces should not be used outside a text area 

#### Tags 
They represent the HTML tags 

#### variables 
the variable can store only a string 

* it can be used as an element attribute in block
* it can be used as an element innerHTML 

** make sure no space in between <- and ' text area '

Syntax:

```
var1<-'class="E"'
var2<-'to be or not to be'

```
to extract form variable
```
->var1
```

#### Block

The base of wise's syntax is the block which has the following properties

* block starts in a new line and must be closed with '.'
* block can contain unlimited number of decentendts
* the level of indentation represents the depth of the html tag
* sibling element is follower block falls in a newline with the same level of indentation 
* child element is a follower block falls in a newline with +1 indentation than the previous element
* the attribute space can be empty or can have a string in between two apostrophs ' '
* the attribute space can be filled using a variable 
* the innerHTML can be empty or have text contnet or another element or both

Syntax:
```
tagA:attributes
    text content
    follower block

```
example

```
tagA:'class="A" style=""'
    tagB:
        'tagB content'
        tagC:
            tagD:
    tagE:->var1
        ->var2
.

```
it will result the following

```
<tagA class="A" style="">
    <tagB>
        'tagB content'
         <tagC>
             <tagD>
            </tagD>
        </tagC>
    </tagB>
    <tagE class="E">
        'to be or not to be'
    </tagE>
</tagA>
```

#### General Container 

A general container shall generate a tag that wrap everything under it line-wise,
if a secode general container follows it will be wrapped 

Syntax:
```
<tag newline
statments
```

```
<gctag1

tagA:
    tagB:
.

tagC:
.
<gctag2

```
It will result the following

```
<gctag1>
    
<tagA>
    <tagB>
    </tagB>
    
</tagA>

<tagC>
    
</tagC>
<gctag2>
    
</gctag2>

</gctag1>

```

#### Block Container 

The main purpose is to contain the block that falss immidiatly under it 

** make sure there are no newlines between the block container and the follower block

Syntax:
```
<:tag: newline
block

```

```
<:tagbc:
tag1:
    tag2:
.
```
it will result the following
```
<tagbc>
<tag1>
    <tag2>
    </tag2>
</tag1>
</tagbc>

```

# Demo work 

you can check a demonstraton of writing a wise code in this demo video 
```
https://drive.google.com/file/d/1nvSuXor40-U_jNITd1j9m3dtqEgMgohF/view
```
resulting the page in link below
```
http://alikatlabi.web.elte.hu/project_wise/demo/demo.a.html
```

# What is the directory structure? Where are the tests?

The file directory structure is provided. The test can be find on the test folder. 
There is some extensions that we must take as in considaration : 
1. *.sh
2. *.test.wise
3. *.test.wise.html

These three extensions will be very important in case of run our first program.
The 1st extension is the shell script, the 2nd is our wise-h language program and the 3rd is "html" file what our code will generate.  


Let's try to run some default codes from our test folder :

Go into folder wise-h 
```bash
cd wise-h
```
Go into folder test 
```bash
cd test
```

Please make sure the extension of the file is ".test.wise" (eg. mycode.test.wise).
```bash
sh testargs.sh <example.test.wise>
```





