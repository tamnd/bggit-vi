# Revert: Hoàn Tác Commit {#revert}

[i[Revert]<]

Giả sử bạn đã thực hiện một số thay đổi và commit chúng, nhưng chúng lại làm
hỏng hết mọi thứ. Bạn muốn quay lại phiên bản cũ hơn của file.

Có cách "lối tắt" mà có thể bạn đã nghĩ đến: detach HEAD (tách HEAD) đến commit
cũ hơn nơi file còn như bạn muốn, sao chép file đó đến nơi an toàn, rồi reattach
HEAD (gắn lại HEAD) vào `main`, rồi sao chép file cũ đè lên file hiện tại trong
working tree. Rồi add và commit! Và cách này cũng hoạt động...

Nhưng hãy làm đúng cách hơn, và chúng ta có thể làm điều đó với `git revert`.

Revert (hoàn tác) cho phép chúng ta thực sự hoàn tác những thay đổi của một
commit duy nhất, ngay cả khi đó không phải commit đưa bạn đến trạng thái hiện
tại. Tức là, giả sử bạn đã thực hiện 30 commit, nhưng hóa ra bạn không muốn
commit số 4 tồn tại nữa. Bạn có thể revert chỉ commit đó!

Thực hiện revert tiêu chuẩn sẽ thực sự tạo một commit mới, và không xóa bất kỳ
commit cũ nào. Theo cách này, nó không rewrite history (viết lại lịch sử) nên
sử dụng phương pháp này an toàn để revert các commit đã được push.

## Thực Hiện Revert

Khá đơn giản. Bạn nhìn lại trong log để tìm commit ID mà bạn muốn revert, và
revert nó.

Ví dụ, nếu bạn có thế này trong log:

``` {.default}
commit 9fef4fe6d42b91c12b5217829e8d98d738f84d61
Author: Brian "Beej Jorgensen" Hall <beej@beej.us>
Date:   Fri Jul 26 16:59:44 2024 -0700

    Added Line 50
```

và bạn quyết định không muốn commit đó nữa, bạn có thể revert nó bằng commit ID
của nó. Ở đây tôi chỉ gõ vài ký tự đầu của hash vì vậy là đủ:

``` {.default}
$ git revert 9fef4
  Auto-merging foo.txt
  [main de415f4] Revert "Added Line 50"
   1 file changed, 1 deletion(-)
```

Không có xung đột (sẽ nói thêm về điều đó ở phần dưới) trong ví dụ này, nên nó
chỉ mở editor cho tôi và cho phép chỉnh sửa commit message. Nhớ rằng revert tạo
một commit mới!

``` {.default .numberLines}
Revert "Added Line 50"

This reverts commit 9fef4fe6d42b91c12b5217829e8d98d738f84d61.
```

Tôi lưu file và `git status` cho biết chúng ta sạch sẽ.

Chạy `git log` nữa sẽ hiển thị commit revert:

``` {.default}
$ git log
  commit de415f4f0cd645b1e551a6ac56e13f73850c88db (HEAD -> main)
  Author: Brian "Beej Jorgensen" Hall <beej@beej.us>
  Date:   Fri Jul 26 17:01:54 2024 -0700

    Revert "Added Line 50"

    This reverts commit 9fef4fe6d42b91c12b5217829e8d98d738f84d61.
```

Bạn có thể revert bất kỳ commit nào, thậm chí những commit bản thân là revert!
Revert cái revert!

Đó là ví dụ khi revert diễn ra suôn sẻ. Nhưng nếu bạn đã thực hiện một số thay
đổi kể từ commit revert mà gần với những thay đổi trong chính commit revert thì
sao? Nó có thể xung đột không? Tất nhiên rồi!

## Xung Đột khi Revert

[i[Revert-->Conflicts]<]

Giống như merge hay rebase, bạn có thể có xung đột với revert. Nếu bạn chưa quen
với việc giải quyết xung đột, hãy xem lại phần
[Xung Đột khi Rebasing](#rebasing-conflicts), vì nó gần nhất với cách xung đột
revert hoạt động.

Ví dụ về xung đột: nếu bạn đã thay đổi dòng 37 trong code, rồi revert một commit
cũng đã thay đổi dòng 37 trong code, Git không thể quyết định phải làm gì. Nên
revert về trước commit của bạn, hay trước commit cũ hơn?

Vậy có xung đột revert cần phải giải quyết. Và nó hoạt động rất giống với các
xung đột khác mà chúng ta đã thấy.

Nếu bạn cố revert và gặp xung đột, nó sẽ hiển thị gì đó như sau:

``` {.default}
$ git revert 5af89a8985c001ec02409d77e093fb7be45495ff
  Auto-merging foo.txt
  CONFLICT (content): Merge conflict in foo.txt
  error: could not revert 5af89a8... Added Line 69
  hint: After resolving the conflicts, mark them with
  hint: "git add/rm <pathspec>", then run
  hint: "git revert --continue".
  hint: You can instead skip this commit with "git revert --skip".
  hint: To abort and get back to the state before "git revert",
  hint: run "git revert --abort".
  hint: Disable this message with
  hint: "git config advice.mergeConflict false"
```

Và nó chỉ ra chúng ta có một vài lựa chọn ở đây. Chúng ta có thể lấy thêm thông
tin với `git status`:

``` {.default}
$ git status
  On branch main
  You are currently reverting commit 5af89a8.
    (fix conflicts and run "git revert --continue")
    (use "git revert --skip" to skip this patch)
    (use "git revert --abort" to cancel the revert operation)

  Unmerged paths:
    (use "git restore --staged <file>..." to unstage)
    (use "git add <file>..." to mark resolution)
	  both modified:   foo.txt

  no changes added to commit (use "git add" and/or "git commit -a")
```

Vậy chúng ta có thể làm một trong những điều sau:

* Chỉnh sửa file, sửa xung đột, rồi `git add` nó, rồi
  `git revert --continue` để chuyển sang commit tiếp theo cần revert (nếu có).
* Hủy hoàn toàn với `git revert --abort`.
* Bỏ qua việc revert commit cụ thể này với `git revert --skip`. Nếu bạn bỏ qua
  tất cả các commit đang revert, nó giống như hủy.

Nếu bạn sửa xung đột, bạn sẽ được nhập commit message cho commit mới giống như
trước.

[i[Revert-->Conflicts]>]

## Revert Nhiều Commit

[i[Revert-->Multiple commits]<]

Bạn có thể chỉ định nhiều revert cùng lúc trên command line.

Ví dụ revert hai commit:

``` {.default}
$ git revert 4c0b3 81d2a
  Auto-merging foo.txt
  [main ab3169d] Revert "Added Line 50"
   1 file changed, 1 deletion(-)
  Auto-merging foo.txt
  [main b63f003] Revert "Added Line 10"
   1 file changed, 1 deletion(-)
```

Và sẽ có hai commit revert mới sau đó. Bạn sẽ chỉnh sửa hai commit message revert
trong suốt quá trình revert đó.

Bạn cũng có thể chỉ định một dải commit. Hãy đảm bảo làm điều này theo thứ tự
từ cũ nhất đến mới nhất, nếu không bạn sẽ gặp lỗi `empty commit set passed`.

``` {.default}
$ git revert 4c0b3^..81d2a
  Auto-merging foo.txt
  [main ab3169d] Revert "Added Line 50"
   1 file changed, 1 deletion(-)
  Auto-merging foo.txt
  [main b63f003] Revert "Added Line 10"
   1 file changed, 1 deletion(-)
```

Một lần nữa, điều đó sẽ tạo nhiều commit, một commit cho mỗi revert. Bạn có
thể [squash những commit đó](#squashing-commits) nếu muốn, hoặc dùng `-n`
("no commit"---không commit) để ngăn Git commit cho đến khi bạn sẵn sàng.

``` {.default}
$ git revert -n ee71e 123e8
  Auto-merging foo.txt
  Auto-merging foo.txt
```

Lúc này, file đã được stage với hai commit đó được revert. Và bạn có thể thực
hiện một commit duy nhất chứa chúng. Và bạn có thể làm điều tương tự khi chỉ
định dải.

Tất nhiên, có thể có xung đột, và bạn sẽ phải giải quyết chúng theo cách thú
vị mà chúng ta đã thảo luận.

[i[Revert-->Multiple commits]>]
[i[Revert]>]
