# Phụ lục: Tạo Playground {#making-playground}

[i[Playground]<]

Trong giới lập trình, *playground* (sân chơi thử nghiệm) là nơi bạn có thể
thoải mái nghịch code và công nghệ mà không sợ làm hỏng hệ thống production.

Có nhiều playground online, nhưng với Git, tôi thấy tự tạo một repo local
còn dễ hơn.

Đây là cách tạo một repo local mới tên `playground` từ thư mục hiện tại.
(Bạn **không** được đang ở trong một Git repo khác lúc này; hãy tạo playground
bên ngoài các repo đang tồn tại.)

``` {.default}
$ git init playground
  Initialized empty Git repository in /user/playground/.git/
```

`playground` không phải tên đặc biệt gì. Bạn có thể gọi nó là `foo` hay bất
cứ thứ gì. Tôi chỉ dùng tên đó cho ví dụ này thôi.

Lệnh đó tạo ra một thư mục con tên `playground` và khởi tạo một Git repo bên trong.

Nói luôn phần cuối: làm sao xóa repo? Chỉ cần xóa thư mục đó đi.

```
$ rm -rf playground   # delete the playground repo
```

Và tạo lại:

``` {.default}
$ git init playground
```

Ta nắm quyền năng tuyệt đối!

> **Repo này chỉ tồn tại trên máy này**; nó không có remote và không có cách
> nào để push. Bạn có thể thêm sau nếu muốn, nhưng playground thường chỉ là
> khu vực tạm để thử nghiệm.

Vào playground xem sao nào.

``` {.default}
$ cd playground
$ ls -la
  total 4
  drwxr-xr-x  3 user group   18 Jul 13 14:43 .
  drwxr-xr-x 22 user group 4096 Jul 13 14:43 ..
  drwxr-xr-x  7 user group  119 Jul 13 14:43 .git
```

Có một thư mục `.git` chứa toàn bộ metadata.

> **Nếu muốn biến thư mục này từ Git repo trở lại thư mục bình thường**,
> chạy lệnh này:
>
> ``` {.default}
> $ rm -rf .git       # Delete the .git directory
> ```
>
> <!-- ` -->
> Lại quyền năng tuyệt đối! Nhưng hãy kiềm chế, đừng làm vậy vội.

Ta có thể làm gì?

*Không* làm được gì? Hãy tạo một file và xem tình hình:

``` {.default}
$ echo "Hello, world" > hello.txt   # Create a file

$ ls -l

  total 4
  -rw-r--r-- 1 user group 13 Jul 13 14:47 hello.txt

$ git status

  On branch main

  No commits yet

  Untracked files:
    (use "git add <file>..." to include in what will be committed)
      hello.txt

  nothing added to commit but untracked files present (use "git
  add" to track)
```

Giờ ta có một file chưa được theo dõi (untracked).

Ta có thể `git add` nó, `git commit` nó, tạo branch (nhánh), merge (gộp nhánh)
rồi tạo conflict (xung đột) rồi giải quyết, rồi `git rebase` và `git reset`
và đủ thứ khác.

Ta không có remote, nên chỉ thiếu mỗi push và pull.

Nhưng thực ra ta có thể làm được cả điều đó! Xem tiếp nhé.

## Clone Bare Repo

[i[Bare repo]] [i[Playground-->Cloning]]

*Bare repo* (repo trống) là repo không có working tree (cây làm việc). Không
thể vào đó để xem file theo nghĩa thông thường. Chỉ có metadata và các
snapshot commit.

[i[Clone]]

Bạn có thể clone, push, và pull bare repo.

Hãy tạo một cái (lại, đặt tên gì cũng được), chú ý tùy chọn `--bare`:

``` {.default}
$ git init --bare origin_repo
  Initialized empty Git repository in /user/origin_repo/
```

Nếu nhìn vào trong đó (thực ra không có lý do gì), bạn chỉ thấy metadata và
các thư mục.

Trước khi dùng được, phải clone nó. Cho tiện, ta làm từ cùng thư mục vừa tạo.

``` {.default}
$ git clone origin_repo playground
  Cloning into 'playground'...
  warning: You appear to have cloned an empty repository.
  done.
```

Rỗng là đương nhiên rồi. Chưa có commit nào cả.

Giờ ta có hai repo trong thư mục này:

* `origin_repo`: bare repo vừa clone, và:
* `playground`: repo clone từ nó.

Vào xem sao:

``` {.default}
$ cd playground
$ git remote -v
  origin    /user/origin_repo (fetch)
  origin    /user/origin_repo (push)
```

Có remote rồi! Tất nhiên. Ta vừa clone repo này, Git tự động thiết lập remote
`origin`.

Nhớ rằng `origin` chỉ là alias (tên gọi tắt) cho một remote nào đó. Ta
quen thấy remote bắt đầu bằng `https` hay `ssh`, nhưng đây là ví dụ về
remote chỉ là một thư mục con trên ổ đĩa của bạn.

[i[Pushing]]

Tạo file, commit, rồi thử push!

``` {.default}
$ echo "Hello, world" > hello.txt
$ git add hello.txt

$ git commit -m added
  [main (root-commit) 4a82a14] added
   1 file changed, 1 insertion(+)
   create mode 100644 hello.txt

$ git push
  Enumerating objects: 3, done.
  Counting objects: 100% (3/3), done.
  Writing objects: 100% (3/3), 907 bytes | 907.00 KiB/s, done.
  Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
  To /user/origin_repo
   * [new branch]      main -> main

$ git branch -va
  * main                4a82a14 added
    remotes/origin/main 4a82a14 added
```

Đã push file lên `origin` thành công.

Cuối cùng, tạo thêm một clone nữa. Trước tiên `cd` trở lại thư mục chứa
`origin_repo` rồi clone lần này vào `playground2`:

``` {.default}
$ git clone origin_repo playground2
  Cloning into 'playground2'...
  done.
```

`cd` vào xem có gì. Đây là bản clone của repo, nên phải thấy `hello.txt`
mà ta đã push từ `playground` trước đó.

``` {.default}
$ cd playground2 

$ ls
  hello.txt

$ cat hello.txt 
  Hello, world
```

*Voila!* Có đó rồi!

Vì `playground` và `playground2` đều là clone của cùng một repo, bạn có thể
push từ cái này và pull từ cái kia để nhận thay đổi.

[i[Pulling]]

Thậm chí có thể tạo thay đổi xung đột và thử `git pull` hay `git pull
--rebase` để xem mọi thứ rối như thế nào và cách sửa.

Nếu mọi thứ đổ vỡ hoàn toàn, xóa các thư mục đi và làm lại. Đây là
playground mà!

## Tự động hóa việc Tạo Playground

[i[Playground-->Automating]<] [i[Shell scripts]]

Việc liên tục xóa rồi tạo lại các repo để học khá mệt mỏi. Tôi gợi ý đặt
các lệnh vào một *shell script* (kịch bản shell), tức là một file văn bản
chứa các lệnh cần chạy.

Giả sử bạn tạo file `buildrepo.sh` với nội dung sau:

``` {.default}
rm -rf playground    # Remove old playground
git init playground  # Create a new one
cd playground
echo "Hello, world!" > hello.txt   # Create hello.txt
echo "foobar" > foobar.txt         # Create foobar.txt
git add hello.txt foobar.txt
git commit -m added
echo "foobar again" >> foobar.txt  # Append text
git add foobar.txt
git commit -m updated
```

Đó chỉ là một loạt lệnh shell. Nhưng đây là phần thú vị: nếu bạn chạy `sh`
(shell) với `buildrepo.sh` làm tham số, nó sẽ chạy tất cả các lệnh đó theo
thứ tự!

``` {.default}
$ sh buildrepo.sh
  Initialized empty Git repository in /user/playground/.git/
  [main (root-commit) 2239237] added
   2 files changed, 2 insertions(+)
   create mode 100644 foobar.txt
   create mode 100644 hello.txt
  [main 0533186] updated
   1 file changed, 1 insertion(+)
```

> **Để debug shell script**, chạy như này: `sh -x buildrepo.sh` và nó sẽ
> hiển thị các lệnh đang được thực thi.

Sau đó, `cd` vào xem kết quả:

``` {.default}
$ cd playground
$ git log
  commit 05331869d77973dfbac38a31c40a44f99225e85d
  Author: User Name <user@example.com>
  Date:   Sat Jul 13 15:19:42 2024 -0700

      updated

  commit 2239237cc44d11e9479dcc610e5d02ad283766ce
  Author: User Name <user@example.com>
  Date:   Sat Jul 13 15:19:41 2024 -0700

      added

$ cat foobar.txt 
  foobar
  foobar again
```

Bằng cách đặt các lệnh khởi tạo vào shell script, nó gần giống như lưu
game vậy. Bất cứ lúc nào muốn playground ở trạng thái đó, chỉ cần chạy lại
script là xong.

[i[Playground-->Automating]>]

[i[Playground]>]
