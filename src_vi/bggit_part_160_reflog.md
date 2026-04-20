# Reference Log (Nhật Ký Tham Chiếu), "reflog"

[i[Reflog]<]

Suốt thời gian qua bạn đã commit, tạo nhánh, làm đủ thứ. Và Git đã theo dõi
bạn, lắng nghe như Anh Cả, ghi lại mọi thứ bạn làm.

Và bạn có thể dùng điều này để có lợi cho mình.

Giả sử bạn đã làm gì đó như hard reset vì bạn muốn từ bỏ nhánh mình đang làm.

Nhưng sau đó, khoan! Bạn thực sự cần thứ gì đó từ một trong những commit bạn
vừa reset qua! Có cách nào lấy lại không? Không có nhánh nào ở đó, và bạn không
nhớ commit ID. Và vì nó không phải là tổ tiên của bất cứ thứ gì, `git log` cũng
không giúp được.

Làm thế nào để lấy lại?

`git reflog` đến giải cứu!

Reflog (reference log---nhật ký tham chiếu) chứa bản ghi về tất cả mọi thứ bạn
đã làm cùng với commit ID, và nó giữ chúng trong 90 ngày[^9721]. Sau thời gian
đó, các orphan commit (commit mồ côi---tức là commit không có nhánh nào ở phía
trên) sẽ bị garbage collected (thu hồi).

[^9721]: Mặc định là 90 ngày. Bạn có thể cấu hình điều này bằng tùy chọn cấu
    hình `gc.reflogExpire`.

## Dùng Để Làm Gì?

[i[Reflog-->Uses]]

Bạn có thể dùng nó cho đủ loại việc.

* Xem các orphan commit
* Tạo lại các nhánh đã bị xóa
* Phục hồi từ một reset tệ hại
* Khám phá thứ tự các thao tác trên repo, ngay cả khi chúng ở trên nhánh khác
* Và nhiều hơn nữa!

Về cơ bản nó cung cấp cho bạn cách nhìn lại lịch sử tuyến tính của repo, và cho
bạn biết các commit hash trên đường đi.

Điều đó có nghĩa là nếu bạn muốn, chẳng hạn, hard reset repo về một trạng thái
cũ hơn, bạn có thể tra cứu commit cũ hơn đó trong reflog[^ab30].

[^ab30]: Nhớ rằng đừng bao giờ viết lại lịch sử trên bất cứ thứ gì bạn đã push,
    tất nhiên.

## Nhìn Lại Orphan Commit

[i[Reflog-->Finding an orphan commit]<]

Hãy chạy ví dụ trong đó chúng ta thực hiện như sau:

1. Commit file `foo.txt` trên nhánh `main`.
2. Tạo nhánh mới `topic1`.
3. Trong nhánh mới này, thêm file khác `bar.txt` và commit.
4. Chỉnh sửa `bar.txt` và commit chỉnh sửa.
5. Quyết định, tại thời điểm này, từ bỏ `topic1`. Chuyển về nhánh `main` và
   force delete (xóa mạnh) `topic1`.
6. Quyết định, tại thời điểm này, rằng thực ra bạn cần xem lại commit đó trong
   `topic1` vì lý do nào đó. Nhưng bạn đã xóa nhánh. Ôi thôi.
7. Tìm trong reflog commit trên `topic1` mà bạn muốn.
8. Chuyển đến commit đó (detaching---tách `HEAD`).

Và đây là trong Git, ít nhất là năm bước đầu tiên:

``` {.default}
$ echo 'Line 1' > foo.txt                  # Create foo.txt
$ git add foo.txt
$ git commit -m 'added foo.txt'
  [main (root-commit) 90bd7cc] added foo.txt
   1 file changed, 1 insertion($)
   create mode 100644 foo.txt
$ git switch -c topic1                     # Switch to topic1
  Switched to a new branch 'topic1'
$ echo 'Line 1' > bar.txt                  # Create bar.txt
$ git add bar.txt
$ git commit -m 'added bar.txt'
  [topic1 4219f83] added bar.txt
   1 file changed, 1 insertion($)
   create mode 100644 bar.txt
$ echo 'Line 2' >> bar.txt                 # Modify bar.txt
$ git add bar.txt
$ git commit -m 'appended to bar.txt'
  [topic1 bf8b8cf] appended to bar.txt
   1 file changed, 1 insertion($)
$ git switch -                             # Switch back to main
  Switched to branch 'main'
$ git branch -D topic1                     # Delete topic1
  Deleted branch topic1 (was bf8b8cf).
```

Lúc này giả sử chúng ta muốn xem lại các commit chúng ta đã thực hiện trên
`bar.txt`. Chúc may mắn với `git log`!

``` {.default}
$ git log
commit 90bd7cc6c3c530798872827ba02cb7db4fd422c2 (HEAD -> main)
Author: User <user@example.com>
Date:   Fri Oct 4 16:24:56 2024 -0700

    added foo.txt
```

Chỉ vậy thôi? Tất cả thứ về `bar.txt` đâu rồi? À, nó ở trên các commit `topic1`,
là con cháu từ commit `90bd7` này. Vì `git log` chỉ hiển thị tổ tiên, chúng ta
không thấy bất kỳ thay đổi `bar.txt` nào.

Vậy cuối cùng, chúng ta đến chủ đề chính của chương này: reflog. Hãy xem thử.

``` {.default}
$ git reflog
  90bd7cc (HEAD -> main) HEAD@{0}: checkout: moving from topic1 to
                                             main
  bf8b8cf HEAD@{1}: commit: appended to bar.txt
  4219f83 HEAD@{2}: commit: added bar.txt
  90bd7cc (HEAD -> main) HEAD@{3}: checkout: moving from main to
                                             topic1
  90bd7cc (HEAD -> main) HEAD@{4}: commit (initial): added foo.txt
```

Ồ, ngon hơn rồi! Tôi thấy các thay đổi tôi đã thực hiện trên `bar.txt` trong
đó! Và tôi thấy commit hash ở bên trái! Điều đó có nghĩa là tôi có thể chuyển
đến commit đó!

``` {.default}
$ git switch --detach bf8b8cf
  HEAD is now at bf8b8cf appended to bar.txt
$ git log
  commit bf8b8cf826bbf667cdd088cfcecbc1086c24de3b (HEAD)
  Author: Brian "Beej Jorgensen" Hall <beej@beej.us>
  Date:   Fri Oct 4 16:24:56 2024 -0700

      appended to bar.txt

  commit 4219f83f22f8a90cb8d57128501facb58b292003
  Author: Brian "Beej Jorgensen" Hall <beej@beej.us>
  Date:   Fri Oct 4 16:24:56 2024 -0700

      added bar.txt

  commit 90bd7cc6c3c530798872827ba02cb7db4fd422c2 (main)
  Author: Brian "Beej Jorgensen" Hall <beej@beej.us>
  Date:   Fri Oct 4 16:24:56 2024 -0700

      added foo.txt
```

Đây rồi log... và chúng ta có nội dung file?

``` {.default}
$ cat bar.txt
  Line 1
  Line 2
```
  
Đúng vậy!

Hãy chuyển lại về `main` và xem điều gì xảy ra.

``` {.default}
$ git switch -
  Warning: you are leaving 2 commits behind, not connected to
  any of your branches:

    bf8b8cf appended to bar.txt
    4219f83 added bar.txt

  If you want to keep them by creating a new branch, this may be a
  good time to do so with:

    git branch <new-branch-name> bf8b8cf

  Switched to branch 'main'
```

Đây là Git đang nói với chúng ta, "Này, tôi sẽ garbage collect hai commit này
sau 90 ngày. Nếu bạn muốn giữ chúng, hãy gắn nhánh vào chúng."

Và nó đang hữu ích cho biết cách làm điều đó.

Vậy dù chúng ta đã force delete `topic1` trước đó, giờ chúng ta có thể đơn giản
tạo lại nó nếu chúng ta không có ý đó. Hãy làm vậy.

``` {.default}
$ git branch topic1 bf8b8cf
$ git switch topic1
  Switched to branch 'topic1'
$ cat bar.txt
  Line 1
  Line 2
```

Như bạn thấy, reflog có thể giúp bạn thoát khỏi đủ loại rắc rối khi bạn nghĩ
mình đã mất commit mãi mãi.

[i[Reflog-->Finding an orphan commit]>]

## Selector trong Reflog

[i[Reflog-->Selectors]<]

Hãy nhìn lại output reflog ví dụ đó:

``` {.default}
$ git reflog
  598c84e (HEAD -> main) HEAD@{0}: checkout: moving from topic1 to
                                             main
  dc3d6a3 HEAD@{1}: commit: appended to bar.txt
  0789880 HEAD@{2}: commit: added bar.txt
  598c84e (HEAD -> main) HEAD@{3}: checkout: moving from main to
                                             topic1
  598c84e (HEAD -> main) HEAD@{4}: commit (initial): added foo.txt
```

Thấy kiểu `HEAD@{3}` trong đó không? Bạn có thể dùng những cái đó để checkout
các commit cụ thể (thay vì dùng commit hash chẳng hạn).

Bây giờ, `HEAD@{3}` **không có nghĩa là** "3 commit trước `HEAD`". Nhưng đó là
định danh bạn có thể dùng để chuyển đến commit cụ thể.

``` {.default}
$ git switch --detach HEAD@{1}
  HEAD is now at dc3d6a3 appended to bar.txt
```

Đơn giản vậy thôi.

[i[Reflog-->Selectors]>]

[i[Reflog]>]
