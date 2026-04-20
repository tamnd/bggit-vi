# Tham Khảo Nhanh

Tra nhanh các lệnh dựa trên việc bạn muốn làm gì! Lưu ý: danh sách này
còn thiếu rất nhiều! Xem man pages để biết thêm!

Trong phần tham khảo này chúng ta dùng các ký hiệu thay thế sau:

* `URL`: Một URL nào đó, có thể là SSH, HTTP, hay thậm chí file local, thường
  là URL bạn đã clone từ đó.
* `FILE`: Đường dẫn đến file, ví dụ `foo/bar.txt`, v.v.
* `DIR`: Đường dẫn đến thư mục, ví dụ `foo/`, v.v.
* `PATH`: Đường dẫn đến thư mục hoặc file
* `BRANCH`: Tên branch nào đó, ví dụ `main`, v.v.
* `REMOTE`: Tên remote, ví dụ `origin`, `upstream`, v.v.
* `HASH`: Commit hash nào đó --- bạn có thể lấy commit hash từ `git log`
  hoặc `git reflog`.
* `CMMT`: Một commit hash, branch, v.v. Bất cứ thứ gì tham chiếu đến một
  commit. Chính thức thì gọi là _tree-ish_, nhưng cái đó nhiều chữ hơn tôi
  muốn gõ đi gõ lại.
* `VARIABLE`: Tên biến cấu hình Git, thường là các từ phân cách bằng dấu chấm.
* `VALUE`: Giá trị tùy ý cho các config Git.
* `TAG`: Tên tag (nhãn)

Ngoài ra, đừng gõ dấu `$` --- đó là dấu nhắc shell. Mọi thứ sau `#` là
comment (ghi chú). Dấu gạch chéo ngược `\` ở cuối dòng cho biết dòng tiếp
tục sang dòng kế.

## Bảng Thuật Ngữ

* **Clone**: bản sao (hoặc hành động sao chép) một repo remote, thường để
  dùng local.
* **Commit**: snapshot (ảnh chụp) của tất cả file trong repo tại một thời
  điểm.
* **Fork**: tính năng của GitHub để tạo bản clone repo của người khác dưới
  tài khoản GitHub của bạn.
* **`HEAD`**: commit hiện đang được checkout/switched to.
* **Index**: tên khác của *stage* (vùng tổ chức).
* **`main`**: tên phổ biến cho branch đầu tiên được tạo.
* **`master`**: tên phổ biến khác cho branch đầu tiên được tạo.
* **`origin`**: tên mặc định cho remote mà repo này được clone từ đó.
* **Pull request**: cách để đưa các thay đổi bạn thực hiện trong fork của
  một repo trở lại repo bạn đã fork từ đó.
* **Remote**: alias (tên gọi tắt) cho một URL đến repo khác. Thường là URL
  HTTP hay SSH.
* **Stage**: nơi bạn tập hợp các file để gói vào một commit.
* **`upstream`**: tên quy ước cho remote bạn đã fork từ đó. Không được thiết
  lập tự động.
* **Working Tree**: tập hợp các file bạn có thể thấy, có thể có thay đổi so
  với commit tại `HEAD`.
* **WT**: viết tắt của working tree.

## Trạng Thái File

* **Untracked** (chưa theo dõi) sang:
  * Unmodified: `git add FILE`
* **Unmodified** (chưa sửa) sang:
  * Modified: Sửa bằng editor của bạn và lưu
  * Untracked/deleted: `git rm --cached FILE`
* **Modified** (đã sửa) sang:
  * Staged: `git add FILE`
  * Unmodified: `git restore FILE` (hủy thay đổi)
  * Untracked/deleted: `git rm --cached FILE`
* **Staged** (đã staged)
  * Unmodified: `git commit FILE` (hoàn tất commit)
  * Modified: `git restore --staged FILE` (unstage)
  * Both modified: `git checkout --merged FILE` (khi merge)

## Cấu Hình

[i[Configuration]i<]

Với tất cả lệnh `git config`, chỉ định `--global` để thiết lập toàn cục
hoặc bỏ qua để đặt giá trị chỉ cho repo này.

``` {.default}
$ git config set VARIABLE VALUE
$ git config get VARIABLE
$ git config list
$ git config unset VARIABLE
$ git config --edit
```

Lệnh lỗi thời cho các phiên bản cũ hơn:

``` {.default}
git config user.email                     # Get
git config user.email "user@example.com"  # Set
git config --unset user.email             # Delete
git config --list                         # List
git config --edit                         # Edit
```

### Đặt danh tính

[i[Configuration-->Name and email]i]
Tên người dùng và email:

``` {.default}
$ git config set --global user.name "Your Name"
$ git config set --global user.email "your-email@example.com"
```

[i[Configuration-->SSH identity]i]
Danh tính SSH:

``` {.default}
$ git config set core.sshCommand \
    "ssh -i ~/.ssh/id_alterego_ed25519 -F none"
```

### Đặt branch mặc định

[i[Configuration-->Default branch]i]

Đây là branch đầu tiên được tạo khi bạn tạo repo mới.

``` {.default}
$ git config set --global init.defaultBranch BRANCH
```

Tên phổ biến là `main`, `master`, `trunk`, và `development`. Hướng dẫn
này dùng `main`.

### Đặt hành vi pull mặc định là merge hay rebase

[i[Configuration-->Pull rebase behavior]i]
``` {.default}
$ git config set --global pull.rebase false   # Merge
$ git config set --global pull.rebase true    # Rebase
```

### Đặt editor mặc định, difftool, và mergetool

Đặt editor mặc định là Vim, mergetool và difftool mặc định là Vimdiff,
tắt prompt cho các tool, và tắt backup của mergetool:

[i[Configuration-->Editor]i]
[i[Configuration-->Difftool]i]
[i[Configuration-->Mergetool]i]
``` {.default}
$ git config set core.editor vim
$ git config set diff.tool vimdiff
$ git config set difftool.prompt false
$ git config set difftool.vimdiff.cmd 'vimdiff "$LOCAL" "$REMOTE"'
$ git config set merge.tool=vimdiff
$ git config set mergetool.vimdiff.cmd \
                             'vimdiff "$LOCAL" "$REMOTE" "$MERGED"'
$ git config --global set mergetool.keepBackup false
```

### Output Git có màu sắc

[i[Configuration-->Color output]i]
``` {.default}
$ git config set color.ui true   # Or false
```

### Tự động sửa lỗi chính tả

[i[Configuration-->Autocorrect]i]
Autocorrect (tự động sửa) sẽ tự động chạy lệnh mà nó đoán bạn muốn. Ví dụ,
nếu bạn gõ `git poush`, nó sẽ giả định bạn muốn `git push`.

``` {.default}
$ git config set help.autocorrect 0   # Ask "Did you mean...?"
$ git config set help.autocorrect 7   # Wait 0.7 seconds before run

$ git config set help.autocorrect immediate  # Just guess and go
$ git config set help.autocorrect prompt     # Prompt then go
$ git config set help.autocorrect never      # Turn autocorrect off
```

### Dịch newline

Xử lý dịch newline tự động. Khuyến nghị đặt true cho Windows (không phải
WSL) và false ở tất cả chỗ khác.

[i[Configuration-->Newline translation]i]
``` {.default}
$ git config set core.autocrlf true  # Windows (non-WSL)
$ git config set core.autocrlf false # WSL, Linux, Mac, C64, etc.
```

### Alias

[i[Alias]i<]

Đặt alias (tên gọi tắt), một vài ví dụ:

``` {.default}
$ git config set --global alias.logn 'log --name-only'
$ git config set alias.aa "add --all"
$ git config set alias.logc "log --oneline --graph --decorate"
$ git config set alias.diffs "diff --staged"
$ git config set alias.lol "log --graph"\
" --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s"\
" %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

Xem alias:

``` {.default}
$ git config get alias.logx
$ git config get --all --show-names --regexp '^alias\.'
$ git config set alias.aliases \
    "config get --all --show-names --regexp '^alias\.'"
```

Theo dõi quá trình chạy alias:

``` {.default}
$ GIT_TRACE=1 git logx
```

[i[Alias]i>]
[i[Configuration]i>]

## Tạo và Clone Repo

[i[Clone]i]

``` {.default}
$ git clone URL       # Clone a URL
$ git clone URL DIR   # Clone a URL to directory
$ git init DIR        # Init repo at directory
$ git init .          # Init repo in the current directory
```

## Thêm, Đổi Tên, Xóa, Commit

[i[Add]i]
[i[Move]i]
[i[Remove]i]
[i[Add]i]
[i[Commit]i<]
``` {.default}
$ git add PATH             # Add PATH to the repo
$ git mv FILE1 FILE2       # Rename ("Move") FILE1 to FILE2
$ git mv FILE2 FILE1       # Undo the above rename
$ git rm FILE              # Delete ("Remove") FILE
$ git add -p FILE          # Add file in patch mode

$ git commit               # Commit files on stage
$ git commit -m "message"  # Commit with a message
```

Amend (sửa) commit --- đừng amend commit đã push trừ khi bạn biết mình
đang làm gì!

[i[Commit-->Amending]i]
``` {.default}
$ git commit --amend               # Amend last commit
$ git commit --amend -m "message"  # Amend with commit message
$ git commit --amend --no-edit     # Don't change commit message
```

[i[Remove-->Unstaging]i]
Để bỏ xóa một file đã staged, chạy hai lệnh này liên tiếp:

``` {.default}
$ git restore --staged FILE
$ git restore FILE
```

Để bỏ xóa một file đã xóa, bạn có thể khôi phục thủ công từ commit cũ,
hoặc revert commit đã xóa nó.

## Xem Trạng Thái

[i[Status]i]
[i[Log]i]
``` {.default}
$ git status             # Show current file states
$ git log                # Show the commit logs
$ git log --name-only    # Also list changed files
$ git log CMMT           # Show log from a specific branch
$ git log CMMT1 CMMT2    # Show logs from multiple branches

$ git log CMMT1..CMMT2   # Show logs from CMMT2 since it
                         # diverged from CMMT1
$ git log CMMT1...CMMT2  # Show logs from CMMT1 and CMMT2
                         # since they diverged
```

## Xem Diff

[i[Diff]i<]
``` {.default}
$ git diff                # Diffs between working tree and stage
$ git diff HEAD^          # Diff from the previous commit to here
$ git diff HEAD^^         # Diff from the 2nd last commit to here
$ git diff HEAD~3 HEAD~2  # Diff from 3rd last to 2nd last commit
$ git diff CMMT           # Diff between CMMT and now
$ git diff CMMT1 CMMT2    # Diff between two commits (older first)

$ git diff CMMT1...CMMT2  # Diff between CMMT2 and the common
                          # ancestor of CMMT1 and CMMT2

$ git diff HEAD~3^!       # Diff between HEAD~3 and its parent
$ git diff -- FILE        # Run a diff just for a specific file
$ git diff HEAD^ -- FILE  # Run a diff just for a specific file

$ git diff -U5          # Show 5 lines of context
$ git diff -w           # Ignore whitespace
$ git diff --name-only  # Only show filenames of changed files
$ git diff --staged     # Diffs between stage and repo
$ git difftool          # Diffs using the configured difftool
```
[i[Diff]i>]

## Branch (Nhánh)

Branch local trông như `branchname`. Remote tracking branch trông như
`remote/branchname`.

[i[Switch]i<]

``` {.default}
$ git switch BRANCH         # Switch to a branch
$ git switch --detach HASH  # Detach HEAD to a commit
$ git switch -              # Switch back to previous commit
```

``` {.default}
$ git switch --detach HEAD^   # Switch to previous commit
$ git switch --detach HEAD^^  # Switch to 2 commit ago
$ git switch --detach HEAD~3  # Switch to 3 commits ago
$ git switch --detach HEAD~99 # Switch to 99 commits ago
```

``` {.default}
$ git switch main   # Reattach HEAD to main
```

[i[Branch]i<]
``` {.default}
$ git branch -v   # List all branches
$ git branch -va  # List all including remote tracking branches
```

``` {.default}
$ git switch -c BRANCH        # Create and switch to BRANCH
$ git branch BRANCH           # Create BRANCH at HEAD
$ git branch BRANCH1 BRANCH2  # Create BRANCH1 at BRANCH2
```
[i[Switch]i>]

``` {.default}
$ git branch -d BRANCH   # Delete fully merged branch
$ git branch -D BRANCH   # Force delete unmerged branch
```

[i[Branch]i>]

Cú pháp lỗi thời (dùng `switch` nếu có thể):

[i[Checkout]i]
``` {.default}
$ git checkout CMMT      # Detach HEAD to a commit
$ git checkout HEAD^     # Detach HEAD to previous commit
$ git checkout HEAD~2    # Detach HEAD to second previous commit
```

## Pull, Push, và Fetch

[i[Pull]i]
``` {.default}
$ git pull               # Pull from remote and merge or rebase
$ git pull --ff-only     # Only allow fast-forward merges
$ git pull --rebase      # Force a rebase on pull
$ git pull --no-rebase   # Force a merge on pull
```

[i[Push]i]
``` {.default}
$ git push                     # Push this branch to its remote

$ git push REMOTE BRANCH       # Create remote tracking branch and
                               # push to remote

$ git push -u REMOTE BRANCH    # Create remote tracking branch and
                               # push to remote, and use subsequent
                               # `git push` commands for this local
                               # branch

$ git push -u origin branch99  # Example

$ git push --tags              # Push all tags to origin
$ git push REMOTE --tags       # Push all tags to specific remote
$ git push REMOTE tag3.14      # Push single tag
```

[i[Fetch]i]
``` {.default}
$ git fetch        # Get data from remote but don't merge or rebase
$ git fetch REMOTE # Same, for a specific remote

```
## Merge (Gộp Nhánh)

[i[Merge]i]
``` {.default}
$ git merge CMMT     # Merge commit or branch into HEAD
$ git merge --abort  # Rollback the current merge
$ git mergetool      # Run mergetool to resolve a conflict

$ git checkout --merged FILE   # Unstage resolved files
```

Nếu xảy ra conflict (xung đột), bạn luôn có thể `--abort`. Nếu không:

1. Sửa conflict.
2. Add các file đã sửa.
3. Commit để hoàn thành merge.

## Remote

[i[Remote]i]
``` {.default}
$ git remote -v                       # List remotes
$ git remote set-url REMOTE URL       # Change remote's URL
$ git remote add REMOTE URL           # Add a new remote
$ git remote rename REMOTE1 REMOTE2   # Rename REMOTE1 to REMOTE2
$ git remote remove REMOTE            # Delete REMOTE
```

## Bỏ Qua File

[i[`.gitignore` file]i<]

Thêm file `.gitignore` vào repo của bạn. Nó áp dụng cho thư mục này và
tất cả thư mục con không phải submodule bên dưới. Thêm mô tả các file cần
bỏ qua vào file này. Comment sau `#` được phép. Dòng trống bị bỏ qua.

Ví dụ `.gitignore`:

``` {.default}
foo.aux     # Ignore specific file "foo.aux"
foo.*       # Ignore all files that start with "foo."
*.tmp       # Ignore all files that end with ".tmp"
frotz/      # Ignore all files in the "frotz" directory
foo[12].txt # Ignore "foo1.txt" and "foo2.txt"
foo?        # Ignore "foo" followed by any single character
frotz/bar   # Ignore file "bar" in directory "frotz"
*           # Ignore everything
```

Ngoại lệ cho các quy tắc trước, cũng hữu ích trong file `.gitignore` ở
các thư mục con để ghi đè quy tắc từ thư mục cha:

``` {.default}
*.txt       # Ignore all text files
!keep.txt   # Except "keep.txt"
```
[i[`.gitignore` file]i>]

## Rebase

[i[Rebase]i]
``` {.default}
$ git rebase CMMT        # Rebase changes onto commit

$ git rebase -i CMMT     # Interactive rebase (squashing commits)

$ git rebase --continue  # Continue processing from conflict
$ git rebase --skip      # Skip a conflicting commit
$ git rebase --abort     # Bail out of rebasing
```

[i[Pull-->Force rebase or merge]i]
```
$ git pull --rebase      # Force a rebase on pull
$ git pull --no-rebase   # Force a merge on pull
```

## Stash (Cất Tạm)

Stash (kho cất tạm) được lưu trên một stack (ngăn xếp).

[i[Stash]i]
``` {.default}
$ git stash push    # Stash changed files
$ git stash         # Effectively the same as "push"
$ git stash FILE    # Stash a specific file
$ git stash pop     # Replay stashed files on working tree
$ git stash list    # List stashed files

$ git stash pop 'stash@{1}'   # Pop stash at index 1
$ git stash pop --index 1     # Same thing
$ git stash drop 'stash@{1}'  # Drop stash at index 1
$ git stash drop --index 1    # Same thing
```

## Revert (Hoàn Tác)

[i[Revert]i]
``` {.default}
$ git revert CMMT     # Revert a specific commit
$ git revert -n CMMT  # Revert but don't commit (yet)

$ git revert CMMT1 CMMT2    # Revert multiple commits
$ git revert CMMT1^..CMMT2  # Revert a range (oldeest first)

$ git revert --continue  # Continue processing from conflict
$ git revert --skip      # Skip a conflicting commit
$ git revert --abort     # Bail out of reverting
```

## Reset

[i[Reset]i]
Tất cả reset đều di chuyển `HEAD` và branch hiện đang checkout sang commit
được chỉ định.

``` {.default}
$ git reset --mixed CMMT  # Set stage to CMMT, don't change WT
$ git reset CMMT          # Same as --mixed
$ git reset --soft CMMT   # Don't change stage or working tree
$ git reset --hard CMMT   # Set stage and WT to CMMT

$ git reset -p CMMT       # Reset file in patch mode
```

Cú pháp lỗi thời:

``` {.default}
$ git reset FILE   # Same as "git restore --staged FILE"
```

## Reflog

[i[Reflog]i]
``` {.default}
$ git reflog      # Look at the reflog
```

...Tôi thừa nhận phần này cần thêm thông tin.

## Cherry-pick

[i[Cherry-pick]i]
``` {.default}
$ git cherry-pick CMMT   # Cherry-pick a particular commit
```

## Blame (Truy Vết)

[i[Blame]i]
``` {.default}
$ git blame FILE                # Who is responsible for each line
$ git blame --date=short FILE   # Same, shorter date format
```

## Submodule (Mô-đun Con)

[i[Submodules]i<]
``` {.default}
$ git clone --recurse-submodules URL       # Clone with submodules
$ git submodule update --recursive --init  # If you cloned without

$ git submodule add URL              # Add submodule
$ git add DIR                        # Add to repo
$ git pull --recurse-submodules      # Pull including submodules

$ git submodule status               # Submodule status
$ git ls-tree HEAD DIR               # Show submod pinned commit
$ git submodule init                 # Set up bookeeeping
$ git submodule update               # Bring in missing submods
$ git submodule update --recursive   # Handle submods of submods
```

[i[Submodules-->Deleting]i]
Xóa submodule --- làm theo thứ tự này. Trong ví dụ này, DIR là tên thư
mục submodule.

``` {.default}
$ git submodule deinit DIR
$ rm -rf .git/modules/DIR
$ git config -f .gitmodules --remove-section submodule.DIR
$ git add .gitmodules
$ git rm --cached DIR
$ git commit -m "remove DIR submodule"
```
[i[Submodules]i>]

## Tag (Nhãn)

[i[Tag]i<]

``` {.default}
$ git tag     # List tags
$ git tag -l  # List tags
```

``` {.default}
$ git tag TAG          # Create a tag on HEAD
$ git tag TAG CMMT     # Create a tag on a specific commit
$ git tag -a TAG       # Create an annotated tag
$ git tag -a TAG CMMT  # On a specific commit
$ git tag -a TAG -m "message" # Add a message to the tag
```

``` {.default}
$ git push --tags          # Push all tags to origin
$ git push REMOTE --tags   # Push all tags to specific remote
$ git push REMOTE tag3.14  # Push specific tag
```

``` {.default}
$ git tag -d tagname          # Delete a tag locally
$ git push REMOTE -d tagname  # Delete a tag on a remote
```

[i[Tag]i>]

## Worktree (Cây Làm Việc)

[i[Worktree]i<]

``` {.default}
$ git worktree list   # List worktrees

$ git worktree add DIR CMMT            # Add worktree at CMMT
$ git worktree add --detach DIR CMMT   # Add, detach head at CMMT
$ git worktree add DIR HASH            # Add, detach head at HASH

$ git worktree remove DIR          # Remove worktree
$ git worktree remove --force DIR  # Remove, lose uncommitted mods
```

[i[Worktree]i>]
