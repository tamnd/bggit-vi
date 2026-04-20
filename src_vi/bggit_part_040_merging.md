# Merging và Conflicts {#merge}

[i[Merge]<]

Chúng ta đã thấy cách fast-forward merge có thể đưa hai branch đồng bộ
mà không có khả năng xung đột.

Nhưng nếu chúng ta không thể fast-forward vì hai branch không phải là
ancestor trực tiếp thì sao? Nói cách khác, nếu các branch đã _phân kỳ_
thì sao? Nếu một thay đổi trong một branch _xung đột_ với một thay đổi
trong branch kia thì sao?

## Một Ví Dụ về Các Branch Phân Kỳ

[i[Branch-->Divergent]]

Hãy nhìn vào một đồ thị commit nơi mọi thứ vẫn còn OK để fast-forward
trong Figure_#.1.

![A direct ancestor branch.](img_040_010.pdf "[A direct ancestor branch.]")

<!--
``` {.default}
         [main]
           |
           v          [somebranch]
    (1)---(2)            |
            \            v
            (3)---(5)---(6)
```
-->

Vâng, mình đã uốn cong đồ thị một chút ở đó, nhưng chúng ta có thể
merge `somebranch` vào `main` như fast-forward vì `main` là ancestor
trực tiếp và `somebranch` do đó là descendant trực tiếp.

Nhưng nếu, **trước khi** chúng ta merge, ai đó tạo thêm một commit trên
branch `main` thì sao? Và bây giờ nó trông như Figure_#.2.

<!--
``` {.default}
               [main]
                 |
                 v    [somebranch]
    (1)---(2)---(7)      |
            \            v
            (3)---(5)---(6)
```
-->

![Not a direct ancestor branch.](img_040_020.pdf "[Not a direct ancestor branch.]")

Có một ancestor chung tại commit `(2)`, nhưng không có đường xuống trực
tiếp. `main` và `somebranch` đã phân kỳ.

Còn hy vọng không? Làm thế nào chúng ta có thể merge?

## Merging Các Branch Phân Kỳ

Hóa ra bạn làm theo cách y hệt như trước.

1. Check out branch bạn muốn merge _vào_.
2. `git merge` branch bạn muốn merge _từ_.

Trong ví dụ Figure_#.2 ở trên, giả sử chúng ta đã làm điều này:

``` {.default}
$ git switch main
$ git merge somebranch    # into main
```

> Ký tự `#` là shell comment delimiter (dấu phân cách comment). Bạn có
> thể paste cái đó vào nếu muốn, nhưng nó không làm gì cả.

Sự khác biệt ở đây là Git không thể đơn giản fast-forward. Nó phải kết
hợp, một cách thần kỳ, các thay đổi từ commit `(6)` **và** commit `(7)`
ngay cả khi chúng hoàn toàn khác nhau.

Điều này có nghĩa là sau khi chúng ta kết hợp hai commit đó, code sẽ
trông như chưa bao giờ có trước đây, một sự kết hợp của hai bộ thay đổi.

Và vì nó trông như chưa có trước, chúng ta cần _thêm một commit_ (thêm
một snapshot của working tree) để đại diện cho việc kết hợp cả hai bộ
thay đổi.

Chúng ta gọi đây là _merge commit_, và Git sẽ tự động tạo nó cho bạn.
(Khi điều này xảy ra, bạn sẽ thấy một editor pop up (bật lên) với một
số văn bản trong đó. Văn bản này là commit message. Chỉnh sửa nó (hoặc
chỉ chấp nhận như vậy) và lưu file rồi thoát khỏi editor. Xem [Thoát
Khỏi Editor](#editor-get-out) nếu bạn cần giúp đỡ về điều này.)

Vì vậy sau merge, chúng ta kết thúc với Figure_#.3.

![Creating a merge commit.](img_040_030.pdf "[Creating a merge commit.]")

<!--

``` {.default}
                         [main]
                           |
                           v    
    (1)---(2)---(7)-------(8)
            \             /
            (3)---(5)---(6)
                         ^
                         |
                      [somebranch]
```
-->

Commit được gán nhãn `(8)` là merge commit. Nó chứa cả các thay đổi
từ `(7)` và `(6)`. Và có commit message bạn đã lưu trong editor.

Và chúng ta thấy `main` đã được cập nhật để trỏ đến nó. Và `somebranch`
không bị ảnh hưởng.

Quan trọng là, chúng ta thấy rằng commit `(8)` có **hai parent**, là
các commit đã được merge lại với nhau để tạo ra nó.

Và nhìn kìa! Nếu chúng ta muốn, chúng ta bây giờ có thể fast-forward
`somebranch` lên `main` vì nó bây giờ là ancestor trực tiếp!

Trong ví dụ này, Git đã có thể xác định cách thực hiện merge tự động.
Nhưng có một số trường hợp nó không thể, và điều này dẫn đến _merge
conflict_ (xung đột merge) đòi hỏi can thiệp thủ công. Bởi bạn.

## Merge Conflicts

[i[Merge-->Conflicts]<]

Nếu hai branch có các thay đổi "cách xa" nhau, Git có thể tìm ra. Nếu
mình chỉnh sửa dòng 20 của một file trong một branch, và bạn chỉnh sửa
dòng 3490 của cùng file trong branch khác, Git có thể tự động đưa cả
hai chỉnh sửa vào.

Nhưng giả sử mình chỉnh sửa dòng 20 trong một commit, và bạn chỉnh sửa
dòng 20 (cùng dòng) trong một commit khác.

Cái nào "đúng"? Git không có ý kiến vì nó chỉ là phần mềm ngu ngốc và
không biết nhu cầu kinh doanh của chúng ta.

Vì vậy nó hỏi chúng ta, trong quá trình merge, để sửa nó. Sau khi chúng
ta sửa, Git có thể hoàn thành merge.

> **Khi bạn đang merging, nếu xung đột xảy ra, _bạn vẫn đang merging_**.
> Git đang ở trạng thái "merge", chờ đợi thêm các lệnh cụ thể cho merge.
>
> Bạn có thể giải quyết xung đột rồi commit các thay đổi để hoàn thành
> merge. Hoặc bạn có thể rút lui khỏi merge như thể bạn chưa bao giờ
> bắt đầu nó.
>
> Điều quan trọng là bạn nhận thức được Git đang ở trạng thái đặc biệt
> và bạn phải hoàn thành hoặc hủy bỏ merge để trở lại bình thường trước
> khi tiếp tục dùng nó.

Hãy có một ví dụ nơi cả `main` và `newbranch` đều thêm một dòng vào
cuối file, tức là cả hai đều thêm dòng 4. Git không biết cái nào là
đúng, vì vậy có xung đột.

``` {.default}
$ git merge newbranch
  Auto-merging foo.py
  CONFLICT (content): Merge conflict in foo.py
  Automatic merge failed; fix conflicts and then commit the result.
```

Bây giờ nếu mình nhìn vào trạng thái, mình thấy chúng ta đang ở trạng
thái merge, như được ghi chú bởi `You have unmerged paths`. Chúng ta
đang ở giữa merge; chúng ta phải đi ra phía trước hoặc lùi lại phía sau
để trở lại bình thường.

``` {.default}
$ git status
  On branch main
  You have unmerged paths.
    (fix conflicts and run "git commit")
    (use "git merge --abort" to abort the merge)

  Unmerged paths:
    (use "git add <file>..." to mark resolution)
	  both modified:   foo.py

  no changes added to commit (use "git add" and/or "git commit -a")
```

Nó cũng gợi ý rằng mình có thể làm một trong hai điều:

1. Sửa các xung đột và chạy `git commit`.
2. Dùng `git merge --abort` để hủy bỏ merge.

Cái thứ hai chỉ rollback (cuộn lại) merge như thể mình chưa bao giờ
chạy `git merge`.

Vì vậy hãy tập trung vào cái đầu tiên. Những xung đột này là gì và làm
thế nào để mình giải quyết chúng?

## Một Xung Đột Trông Như Thế Nào

Thông báo lỗi của mình ở trên đang nói với mình rằng `foo.py` có unmerged
paths (đường dẫn chưa được merge). Vì vậy hãy nhìn vào những gì đã xảy
ra với file đó.

Trước khi mình bắt đầu bất kỳ điều gì trong số này, file `foo.py` chỉ
có thế này trong nó trên branch `main`:

``` {.default}
print("Commit 1")
```

Và mình đã thêm một dòng để nó trông như thế này:

``` {.default}
print("Commit 1")
print("Commit 4")
```

Và đã commit nó.

Nhưng điều mình không nhận ra là teammate (đồng đội) của mình cũng đã
tạo một commit khác trên `newbranch` thêm các dòng khác vào cuối file.

Vì vậy khi mình đi merge `newbranch` vào `main`, mình gặp xung đột này.
Git không biết những dòng bổ sung nào là đúng.

**Đây là nơi bắt đầu vui.** Hãy chỉnh sửa `foo.py` ở đây ở giữa merge
và xem nó trông như thế nào:

``` {.default}
print("Commit 1")
<<<<<<< HEAD
print("Commit 4")
=======
print("Commit 2")
print("Commit 3")
>>>>>>> newbranch
```

Cái quỷ gì vậy? Git đã hoàn toàn làm loạn nội dung file của mình!

Đúng vậy! Nhưng không phải vô lý; hãy xem những gì ở trong đó.

Chúng ta có ba delimiter (dấu phân cách): `<<<<<<`, `======` và `>>>>>>`.

Tất cả mọi thứ từ delimiter trên cùng đến dấu giữa là những gì ở trong
`HEAD` (branch bạn đang ở và merging _vào_).

Tất cả mọi thứ từ delimiter giữa đến dưới cùng là những gì ở trong
`newbranch` (branch bạn đang merging _từ_).

Vì vậy Git đã "hữu ích" cung cấp cho chúng ta thông tin chúng ta cần
để đưa ra một quyết định có cơ sở hơn về phải làm gì.

Và đây chính xác là các bước chúng ta phải làm theo:

1. Chỉnh sửa (các) file có xung đột, xóa tất cả những dòng thêm đó,
   và **làm cho (các) file đúng** (Right).
2. `git add` để thêm (các) file.
3. `git commit` để hoàn tất merge.

Bây giờ, khi mình nói "làm cho file *Right* (đúng)", điều đó có nghĩa
là gì? Điều đó có nghĩa là mình cần trò chuyện với teammate và tìm hiểu
code này phải làm gì. Chúng ta rõ ràng có những ý tưởng khác nhau, và
chỉ một trong số đó là đúng.

Vì vậy chúng ta trò chuyện và giải quyết. Cuối cùng chúng ta quyết định
file nên trông như thế này:

``` {.default}
print("Commit 1")
print("Commit 4")
print("Commit 3")
```

Và sau đó mình (vì mình là người đang merge), chỉnh sửa `foo.py` và xóa
tất cả merge delimiters và mọi thứ khác, và làm cho nó trông chính xác
như chúng ta đã đồng ý. Mình làm cho nó trông *Right* (đúng).

Sau đó mình thêm file vào stage:

``` {.default}
$ git add foo.py
$ git status
  On branch main
  All conflicts fixed but you are still merging.
    (use "git commit" to conclude merge)

  Changes to be committed:
	  modified:   foo.py
```

Lưu ý rằng `git status` đang nói với mình chúng ta vẫn đang ở trạng
thái merging, nhưng mình đã giải quyết các xung đột. Nó nói với mình
`git commit` để kết thúc merge.

> **Nếu mình thêm file xung đột quá sớm thì sao?** Ví dụ, nếu bạn thêm
> nó nhưng sau đó bạn nhận ra vẫn còn các xung đột chưa được giải quyết
> hoặc file chưa đúng thì sao? Nếu bạn chưa commit, bạn có một vài tùy
> chọn. (Nếu bạn đã commit, tất cả những gì bạn có thể làm là
> [reset](#reset) hoặc [revert](#revert).)
>
> Một tùy chọn là chỉ chỉnh sửa file lại, và re-add (thêm lại) khi nó
> hoàn tất. (Sau khi chỉnh sửa file sẽ hiển thị dưới dạng "change not
> staged for commit" cho đến khi bạn thêm lại.)
>
> Một tùy chọn khác là di chuyển file ra khỏi stage với `git checkout
> --merge` trên file để đưa nó về trạng thái "both modified". Hữu ích
> là điều này sẽ không xóa các thay đổi bạn đã thêm. Điều này đặc biệt
> hữu ích nếu bạn đang dùng [merge tool](#mergetool).

Vì vậy bây giờ chúng ta đã thêm file, hãy tạo merge commit. Ở đây
chúng ta đang tạo merge commit thủ công, không giống như ở trên nơi Git
đã có thể tạo tự động.

``` {.default}
$ git commit -m "Merged with newbranch"
  [main 668b506] Merged with newbranch
```

Và đó là xong! Hãy kiểm tra trạng thái chỉ để chắc chắn:

``` {.default}
$ git status
  On branch main
  nothing to commit, working tree clean
```

Thành công!

Chỉ để kết thúc, hãy nhìn vào log tại thời điểm này:

``` {.default}
$ git log
  commit 668b5065aa803fa496951b70159474e164d4d3d2 (HEAD -> main)
  Merge: e4b69af 81d6f58
  Author: User Name <user@example.com>
  Date:   Sun Feb 4 13:18:09 2024 -0800

      Merged with newbranch

  commit e4b69af05724dc4ef37594e06d0fd323ca1b8578
  Author: User Name <user@example.com>
  Date:   Sun Feb 4 13:16:32 2024 -0800

      Commit 4

  commit 81d6f58b5982d39a1d92af06b812777dbb452879 (newbranch)
  Author: User Name <user@example.com>
  Date:   Sun Feb 4 13:16:32 2024 -0800

      Commit 3

  commit 3ab961073374ec26734c933503a8aa988c94185b
  Author: User Name <user@example.com>
  Date:   Sun Feb 4 13:16:32 2024 -0800

      Commit 1
```

Chúng ta thấy một vài điều. Một là merge commit của chúng ta được trỏ
bởi `main` (và `HEAD`). Và nhìn xuống vài commit, chúng ta thấy ancestor
trực tiếp bây giờ của mình, `newbranch` tại Commit 3.

Chúng ta cũng thấy một dòng `Merge:` trên commit đầu đó. Nó liệt kê
commit hash cho hai commit mà nó đến từ (7 chữ số đầu, dù sao), vì
merge commit có hai parent.

## Tại Sao Merge Conflicts Xảy Ra

Nhìn chung, đó là vì bạn chưa phối hợp với nhóm về ai chịu trách nhiệm
cho những phần code nào. Nhìn chung hai người không nên chỉnh sửa cùng
các dòng code trong cùng một file cùng một lúc.

Tuy nhiên, có những trường hợp hoàn toàn nó xảy ra và được mong đợi.
Điều quan trọng là giao tiếp với nhóm của bạn khi giải quyết xung đột
nếu bạn không biết điều gì là *Right* (đúng).

## Merging với IDE hoặc Merge Tools Khác

Các IDE như VS Code có thể có một chế độ merge đặc biệt nơi bạn có thể
chọn một bộ thay đổi hay bộ kia, hoặc cả hai. Có lẽ "cả hai" là những
gì bạn muốn, nhưng hãy đưa ra quyết định có cơ sở về vấn đề này.

Ngoài ra, ngay cả khi chọn "cả hai", có thể là editor đặt chúng theo
thứ tự sai. Tùy bạn đảm bảo file là *Right* (đúng) trước khi tạo commit
cuối để hoàn thành merge.

Bạn có thể làm điều này bằng cách, sau khi công cụ được dùng để giải
quyết xung đột, mở file lại trong một cửa sổ mới và đảm bảo nó theo ý
bạn, và chỉnh sửa nó nếu không đúng.

Để biết thêm thông tin về merge tools, xem chương [Mergetool](#mergetool).

## Các Ý Tưởng Lớn về Merge

***ĐỪNG HOẢNG LOẠN!*** Nếu bạn có merge conflict, bạn hoàn toàn có thể
giải quyết được. Chúng là sự kiện phổ biến, và bạn càng làm nhiều, bạn
càng giỏi hơn.

Không có gì phải lo lắng. Mọi thứ đều ở trong lịch sử commit của Git,
vì vậy ngay cả khi bạn làm hỏng, bạn luôn có thể lấy lại mọi thứ như
trước.

[i[Merge-->Conflicts]>]
[i[Merge]>]
