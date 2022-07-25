


function begin {
  sleep 0.1; tmux kill-session -t '=git-tut-session' 2> /dev/null
  sleep 0.1; tmux new-session -d -s git-tut-session -x 80 -y 24
  sleep 0.1; tmux new-window -d -t '=git-tut-session' -n git-tut-window -c _site zsh

  sleep 0.1; tmux send-keys -t '=git-tut-session:=git-tut-window' "export PS1='\$ '" ENTER
  sleep 0.1; tmux send-keys -t '=git-tut-session:=git-tut-window' clear Enter
}

function end {
  sleep 0.1; tmux kill-session -t '=git-tut-session'
}

function run {
  sleep 0.1; tmux send-keys -t '=git-tut-session:=git-tut-window' "$@"
}

function snapshot {
  sleep 0.1; tmux capture-pane -t '=git-tut-session:=git-tut-window' -b git-tut-pane
  sleep 0.1; tmux save-buffer -b git-tut-pane $1
}

function main {

cat << EOL
<!DOCTYPE html>
<html>
  <head>
  <title>Git</title>
  <style>
body {
background: white;
}

.section {
  padding: 8pt;
background: #DDD;
}

.slide {
  border: 1px solid #444;
  margin-top: 12pt;
}

.preamble {
  background: #F2F2F2;
  padding: 4pt;
  margin: 4pt;
}

.sample {
    margin: 8pt;
    padding: 8pt;
    font-family: monospace;
    white-space: pre;
    background: white;
}
  </style>
  </head>
<body>
EOL


begin
mkdir -p /tmp/demodir
run "cd /tmp/demodir" ENTER

## ############################################################################
## Section, Chapter 1
echo '<div id="ch1" class="section">'



## ---------------------------------------------------------------------------



echo '<div class="slide">'
echo '<div class="preamble">In an empty directory, we will initialize git</div>'
echo '<div class="sample">'

run clear ENTER
run 'git init' Enter
TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'



## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">We populate main.py with some section delimiting comments</div>'
echo '<div class="sample">'

cat << EOL > /tmp/demodir/main.py
# 1

# 2

# 3

# 4
EOL

run clear ENTER
run "cat main.py" Enter
run "git add main.py" Enter
run "git status" Enter
run "git add main.py" Enter
run "git commit -m 'First commit'" Enter
TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'

## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Before we go forward, let us setup a branch to be the base of our workingtree. This will be useful later on, but may not make much sense yet.</div>'
echo '<div class="sample">'
run clear ENTER
run "git branch base" Enter
TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Now we add a "feature"</div>'
echo '<div class="sample">'

run clear ENTER
cat << EOL > /tmp/demodir/main.py
# 1
print 'Feature 1'
# 2

# 3

# 4
EOL
run "cat main.py" Enter
run "git status" Enter


TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">With the file changed we can see the change that was made</div>'
echo '<div class="sample">'

run clear ENTER
run "git diff" Enter
TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Because this file was previously added, we can automatically include it in the next commit, without needing to specifically add it, with the "-a" flag.</div>'
echo '<div class="sample">'

run clear ENTER
run "git commit -am 'add feature 1'" Enter
TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">We can use "git log" to see the commits we have made so far.</div>'
echo '<div class="sample">'
run clear ENTER

run "git log" ENTER

TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Another way of viewing the logs is as a tree, with a more complex git log statement. We will make extensive use of this log form later in the tutorial.</div>'
echo '<div class="sample">'
run clear ENTER


run "git log --all --decorate --oneline --graph" ENTER

TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'

## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Now we are going to rapid fire add three new commits</div>'
echo '<div class="sample">'
run clear ENTER


cat << EOL > /tmp/demodir/main.py
# 1
print 'Feature 1'
# 2
print 'Feature 2'
# 3

# 4
EOL
run "cat main.py" Enter
run "git diff" Enter
run "git commit -am 'add feature 2'" Enter


TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Now we are going to rapid fire add three new commits</div>'
echo '<div class="sample">'
run clear ENTER

cat << EOL > /tmp/demodir/main.py
# 1
print 'Feature 1'
# 2
print 'Feature 2'
# 3
print 'Feature 3'
# 4
EOL
run "cat main.py" Enter
run "git diff" Enter
run "git commit -am 'add feature 3'" Enter

TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'




## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Our "git log" command is outputting quite a bit more... making it no longer fit in my slides...</div>'
echo '<div class="sample">'
run clear ENTER

run "git log | cat" ENTER

TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">But our graph view is still fits nicely</div>'
echo '<div class="sample">'
run clear ENTER


run "git log --all --decorate --oneline --graph" ENTER

TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">For this presentation we will re-render the history in a more graphical form, using some bespoke bash scripting + graphviz.</div>'

tree_slide

echo '</div>'

## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Now we are going to start reworking our git history a bit, so before we do anything confusing, lets leave ourselves an escape hatch by making a branch called "inorder"</div>'
echo '<div class="sample">'
run clear ENTER

run "git branch inorder" ENTER
run "git log --all --decorate --oneline --graph" ENTER

TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">We can see the new "inorder" branch show up in our tree view as well.</div>'

tree_slide

echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Now we want to do something complicated, to simulate a more complex development process.  Let us pretend we want to add the fourth feature, but we are going to add it as if it were done in parallel to our current lineage, adding it on top of our first commit. We will begin by checkout out the base.</div>'
echo '<div class="sample">'
run clear ENTER

run "git checkout base" ENTER

run "git log --all --decorate --oneline --graph" ENTER

TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">We can see that our HEAD has moved back to the original commit, and is now attached to the "base" branch, but the "main" and "inorder" branches remain where we left them.</div>'

tree_slide

echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Because we want to leave our "base" branch at the beginning, we will start a new branch, called feature_4.  By calling git checkout -b we can create a new branch and attach HEAD to it.</div>'
echo '<div class="sample">'
run clear ENTER

run "git checkout -b feature_4" ENTER

run "git log --all --decorate --oneline --graph" ENTER

TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">We can see that our HEAD has moved back to the original commit, and is now attached to the "base" branch, but the "main" and "inorder" branches remain where we left them.</div>'

tree_slide

echo '</div>'




## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Now that we are at the base, we can add our fourth feature.</div>'
echo '<div class="sample">'
run clear ENTER

cat << EOL > /tmp/demodir/main.py
# 1

# 2

# 3

# 4
print 'Feature 4'
EOL
run "cat main.py" Enter
run "git diff" Enter
run "git commit -am 'add feature 4'" Enter




TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">The new tree can be seen on the command line</div>'
echo '<div class="sample">'
run clear ENTER

run "git log --all --decorate --oneline --graph" ENTER

TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'



## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">The new tree can be seen from our graphical tree.</div>'

tree_slide

echo '</div>'

## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Before we do any further manipulations, we will leave a branch at this commit as well, with git branch only_feature_4.</div>'
echo '<div class="sample">'
run clear ENTER

run "git branch only_feature_4" ENTER
run "git log --all --decorate --oneline --graph" ENTER

TMPNAME="$(mktemp)"
snapshot $TMPNAME

cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'



## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble">Note that HEAD is not attached to our new branch, it will be left behind as we move HEAD and the feature_4 branch that HEAD is attached to.</div>'

tree_slide

echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble"></div>'
echo '<div class="sample">'
run clear ENTER



TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'



## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble"></div>'
echo '<div>'

echo '<h1> APPENDIX </h1>'


echo '</div>'
echo '</div>'










## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble"></div>'
echo '<div class="sample">'

cat << EOF | dot -Tsvg
digraph G { a -> b; }
EOF

echo '</div>'
echo '</div>'

## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble"></div>'
echo '<div class="sample">'
run clear ENTER



TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble"></div>'
echo '<div class="sample">'
run clear ENTER



TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble"></div>'
echo '<div class="sample">'
run clear ENTER



TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble"></div>'
echo '<div class="sample">'
run clear ENTER



TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble"></div>'
echo '<div class="sample">'
run clear ENTER



TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'


## ---------------------------------------------------------------------------

echo '<div class="slide">'
echo '<div class="preamble"></div>'
echo '<div class="sample">'
run clear ENTER



TMPNAME="$(mktemp)"
snapshot $TMPNAME
cat ${TMPNAME}
rm ${TMPNAME}
echo '</div>'
echo '</div>'





## End section, Chapter 1
echo '</div>'


# Example of directly outputting graphs
# echo 'digraph G { a -> b}' | dot -T svg




cat << EOL
</body>
</html>
EOL

end

rm -rf /tmp/demodir

}

function tree {

(cd /tmp/demodir; echo 'digraph G {';  for x in $(git log --oneline --all --pretty=format:%H); do echo '"'$x'"' ' [shape=box,fontsize=10,label="'$(git show --pretty=format:%h:%s -q $x -- )'"];' ; done;  for x in $(git log --oneline --all --pretty=format:%H); do echo \"$x\" ' -> ' \"$(git show --pretty=format:%P -q $x --)\" ';' | awk '$3 != "\"\""'; done; for x in $(git branch | awk '{print $NF}'); do echo \"$x\" '[style=filled,fontsize=10,fillcolor=cyan];'; echo  \"$x\" '->' \"$(git show --pretty=format:%H -q $x --)\" ';'; done; echo 'HEAD [style=filled,fontsize=10,fillcolor=gold];'; echo  \"HEAD\" '->' \"$(git show --pretty=format:%H -q HEAD --)\"; echo '"HEAD" -> ' $(git branch | awk '$1 == "*" {print $2}') ';' ; echo '}') | grep . | dot -Tsvg

}

function tree_slide {
echo '<div style="margin: 8pt; padding: 8pt; background-color: white; height:638; width: 375;">'

tree

echo '</div>'

}



main



