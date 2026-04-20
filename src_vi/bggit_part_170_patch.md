# Patch Mode: Áp Dụng Thay Đổi Từng Phần

[i[Patch mode]<]

Rất nhiều lệnh Git tuân theo switch (công tắc) `-p` để đưa chúng vào ***patch
mode*** (chế độ patch). Đây là chế độ mạnh mẽ cho phép bạn chọn *một số* thay
đổi cho một lệnh cụ thể, nhưng không phải *tất cả* thay đổi.

Các lệnh dùng `-p` bao gồm `add`, `reset`, `stash`, `restore`, `commit`, và
nhiều hơn nữa.

Về cơ bản bất cứ khi nào bạn có thay đổi trong file và đang nghĩ, "Tôi muốn làm
gì đó chỉ với *một số* thay đổi này", patch mode sẽ giúp bạn.

Một số thuật ngữ: Git gọi một tập hợp các thay đổi gần nhau là *hunk* (khối).
Ví dụ là nếu bạn chỉnh sửa hàm `foo()` bằng cách thêm vài dòng và chỉnh sửa
hàm `bar()` bằng cách thêm vài dòng, bạn sẽ có hai hunk, một cho mỗi nhóm thay
đổi.

Patch mode cho phép bạn chọn hunk nào sẽ được thao tác.

## Add File trong Patch Mode

[i[Patch mode-->Add]<]

Giả sử bạn có commit đã thêm `Line 1` đến `Line 8` trong file:

``` {.default}
Line 1
Line 2
Line 3
Line 4
Line 5
Line 6
Line 7
Line 8
```

Và chúng ta thực hiện vài thay đổi, thêm một dòng ở đầu và cuối:

``` {.default}
Line BEGIN
Line 1
Line 2
Line 3
Line 4
Line 5
Line 6
Line 7
Line 8
Line END
```

Và tôi sắp add và commit, nhưng tôi nhận ra rằng tôi chỉ muốn thêm `Line BEGIN`
lúc này, không phải `Line END`.

Nếu tôi thực hiện `git add` thông thường, nó sẽ thêm cả hai thay đổi vào stage.
Nhưng nếu tôi dùng `git add -p`, chúng ta có thể chọn cái này hoặc cái kia.
Hãy thử.

Đầu tiên hãy xem diff của chúng ta.

``` {.default}
$ git diff
  diff --git a/foo.txt b/foo.txt
  index a982fdc..125f6ac 100644
  --- a/foo.txt
  +++ b/foo.txt
  @@ -1,3 +1,4 @@
  +Line BEGIN
   Line 1
   Line 2
   Line 3
  @@ -6,3 +7,4 @@ Line 5
   Line 6
   Line 7
   Line 8
  +Line END
```

Nhìn qua đó, bạn thấy chúng ta đã thêm `Line BEGIN` ở đầu và `Line END` ở cuối.
(Nhớ rằng các dòng có `+` phía trước là những bổ sung trong diff.)

Giờ hãy thực hiện patch add.

``` {.default}
$ git add -p
  diff --git a/foo.txt b/foo.txt
  index a982fdc..125f6ac 100644
  --- a/foo.txt
  +++ b/foo.txt
  @@ -1,3 +1,4 @@
  +Line BEGIN
   Line 1
   Line 2
   Line 3
  (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? 
```

Ồ, nhiều lựa chọn vậy! Những cái dễ là `y` cho "yes" (có) và `n` cho "no"
(không). Và bạn cũng có thể gõ `?` để được trợ giúp chi tiết hơn.

Ngoài ra chúng ta thấy đây là hunk 1 trong 2, điều này có nghĩa là chúng ta có
một thay đổi ở đầu file và một thay đổi khác ở cuối.

Trong trường hợp này, chúng ta thực sự muốn giữ hunk đầu tiên này, nên chúng ta
trả lời `y`.

Và sau đó chúng ta đến hunk 2 trong 2:

``` {.default}
(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? y
@@ -6,3 +7,4 @@ Line 5
 Line 6
 Line 7
 Line 8
+Line END
(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]?
```

Và với cái này, tôi sẽ nói `n` để không stage nó. Sau đó chúng ta quay lại
shell prompt.

Giờ tôi sẽ gõ `git status` để xem chúng ta đang ở đâu, nhưng trước tiên tôi
muốn bạn nghĩ xem nó sẽ nói gì với chúng ta.

Chúng ta có một trong các thay đổi được staged, và thay đổi kia chưa staged. Các
file ở trạng thái nào khi có thay đổi chưa staged? Và khi có thay đổi đã staged?
Chúng ta có cả hai lúc này, phải không?

``` {.default}
$ git status
  On branch main
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  modified:   foo.txt

  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working
    directory)
	  modified:   foo.txt
```

Đúng vậy! Vì chúng ta chỉ add một phần thay đổi trong file, các thay đổi đã add
ở trên stage, và các thay đổi chưa add vẫn ở trong working directory. Nó *phải*
như vậy vì chúng ta chưa staged *tất cả* thay đổi của mình!

Lúc này chúng ta có thể tiến hành commit các thay đổi đã add một phần đang trên
stage.

[i[Patch mode-->Add]>]

## Reset File trong Patch Mode

[i[Patch mode-->Reset]<]

Thứ gần như ngược lại với `git add -p` là `git reset -p`. Bạn có thể dùng
`reset -p` để thay đổi có chọn lọc các hunk *trên stage*.

Chính cái phần cuối đó làm nó hơi kỳ lạ, nhưng bạn có thể nghĩ `add -p` là
thêm có chọn lọc các hunk vào stage từ working tree, và `reset -p` là xóa có
chọn lọc các hunk khỏi stage so với commit cụ thể.

Tức là, tôi có thể reset về commit cũ hơn, nhưng chọn hunk nào để reset.

> **Đây không phải hard, soft, hay mixed reset.** Nó là thứ riêng của nó. Nếu
> bạn cố chỉ định loại reset nhất định ngoài `-p`, Git sẽ phàn nàn. Có thể lập
> luận rằng đây nên là lệnh hoàn toàn khác, nhưng đó là Git cho bạn đấy!

Giả sử tôi có hai commit. Trong cái đầu tiên, tôi đã thêm `Line 1` đến `Line 8`,
và trong commit thứ hai tôi đã thêm `Line BEGIN` và `Line END`, giống như ví dụ
trước.

Nhưng giờ tôi quyết định muốn reset `Line END`, nhưng nó là một phần của commit
khác. Tôi có thể tách nó ra bằng `git reset -p`. Hãy làm vậy.

Đây là log của tôi:

``` {.default}
commit d2d5899a253d5ce277d4d5981d03a43e68da6677 (HEAD -> main)
Author: User Name <user@example.com>
Date:   Fri Oct 11 16:12:26 2024 -0700

    updated

commit aae754f46130b6d86680e74caa98642becc88d6e
Author: User Name <user@example.com>
Date:   Fri Oct 11 16:12:04 2024 -0700

    added
```

Tôi muốn thực hiện partial reset (reset một phần) về commit cũ hơn `aae75`. Và
tôi sẽ nói "no" tôi không muốn reset hunk đầu tiên, và "yes" tôi muốn reset cái
thứ hai. Đây là trông như thế nào:

``` {.default}
$ git reset -p aae75
  diff --git b/foo.txt a/foo.txt
  index 125f6ac..a982fdc 100644
  --- b/foo.txt
  +++ a/foo.txt
  @@ -1,4 +1,3 @@
  -Line BEGIN
   Line 1
   Line 2
   Line 3
  (1/2) Apply this hunk to index [y,n,q,a,d,j,J,g,/,e,p,?]? n
  @@ -7,4 +6,3 @@ Line 5
   Line 6
   Line 7
   Line 8
  -Line END
  (2/2) Apply this hunk to index [y,n,q,a,d,K,g,/,e,p,?]? y
```

Câu hỏi đầu tiên đang hỏi, "Bạn có muốn xóa 'Line BEGIN' không?" Và tôi nói
"no". Và câu hỏi thứ hai hỏi "Bạn có muốn xóa 'Line END' không?" Và tôi nói
"yes".

Chúng ta đang ở đâu?

``` {.default}
$ git status
  On branch main
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  modified:   foo.txt

  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working
    directory)
	  modified:   foo.txt
```

Hmm. Hãy kiểm tra sự khác biệt giữa stage và `HEAD`.

``` {.default}
$ git diff --staged
  diff --git a/foo.txt b/foo.txt
  index 125f6ac..e0e1d89 100644
  --- a/foo.txt
  +++ b/foo.txt
  @@ -7,4 +7,3 @@ Line 5
   Line 6
   Line 7
   Line 8
  -Line END
```

Cái đó cho chúng ta biết rằng, so với `HEAD`, stage có `Line END` bị xóa. Điều
đó tốt, vì đó là những gì chúng ta yêu cầu với `reset -p`. Vậy chúng ta đang
trên đúng hướng.

Nhưng tại sao `foo.txt` lại modified? Hãy xem:

``` {.default}
$ git diff
  diff --git a/foo.txt b/foo.txt
  index e0e1d89..125f6ac 100644
  --- a/foo.txt
  +++ b/foo.txt
  @@ -7,3 +7,4 @@ Line 5
   Line 6
   Line 7
   Line 8
  +Line END
```

Cái này cho chúng ta biết rằng, so với stage, working tree có `Line END` được
thêm vào cuối.

Và đúng vậy, nếu chúng ta nhìn vào file `foo.txt` trong working tree, *nó vẫn
còn `Line END` trong đó*.

``` {.default}
$ cat foo.txt
  Line BEGIN
  Line 1
  Line 2
  Line 3
  Line 4
  Line 5
  Line 6
  Line 7
  Line 8
  Line END
```

Ý nghĩa của tất cả điều này là gì? Có nghĩa là `reset -p` đã can thiệp vào
stage, nhưng không phải working tree. Working tree của chúng ta vẫn giống như
khi commit cuối cùng. (`git diff HEAD` sẽ không hiển thị thay đổi.)

Giờ, thừa nhận là, điều này có thể không phải là điều bạn muốn. Có thể bạn muốn
reset hunk **và** cũng reset working tree về hunk đó.

Nhưng chúng ta vẫn có thể đến đó! Nhớ rằng hunk đã reset đang trên stage sẵn
sàng để commit! Hãy làm vậy!

``` {.default}
$ git commit -m "remove END"
  [main 46badfe] remove END
   1 file changed, 1 deletion(-)
```

Đây rồi. Giờ stage và `HEAD` giống nhau, cả hai đều đã xóa `Line END`. Nhưng
`Line END` vẫn tồn tại trong working tree của chúng ta, như `status` thông báo:

``` {.default}
$ git status
  On branch main
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working
    directory)
	  modified:   foo.txt
```

Vậy làm sao chúng ta đưa thay đổi reset trở lại vào working tree? Câu trả lời
ngay trong các gợi ý.

``` {.default}
$ git restore foo.txt
```

Đây rồi. Giờ chúng ta đều trên cùng trang với `Line END` đã bị xóa hoàn toàn.

> **Còn một cách khác để đồng bộ stage và working tree trong quá trình patch
> reset.** Sau khi bạn thực hiện `reset -p`, bạn có thể sao chép file `foo.txt`
> từ stage vào working tree bằng:
>
> ``` {.default}
> git checkout -- foo.txt
> ```
>
> <!-- ` -->
> Điều đó sẽ làm cho stage và working tree giống nhau, vì vậy mọi thứ sẽ đồng
> bộ khi commit hoàn tất.

[i[Patch mode-->Reset]>]

## Các Lệnh Patch Mode Khác

Bạn có thể dùng `-p` với `stash`, `restore`, `commit`, và nhiều hơn nữa. Giao
diện người dùng hoạt động về cơ bản giống như mô tả ở trên. Xem các trang
manual (hướng dẫn) cho từng lệnh cụ thể để tìm hiểu thêm.

[i[Patch mode]>]
