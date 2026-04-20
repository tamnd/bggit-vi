# Rebase: Di Chuyển Commit {#rebase}

[i[Rebase]<]

Tôi sẽ bắt đầu với Quy Tắc Số Một của Rebase: ***không bao giờ rebase bất cứ thứ gì bạn đã push***. Nghĩa là chỉ rebase các thay đổi cục bộ mà không ai khác đã thấy. Bạn có thể push chúng sau khi rebase.

Đây là nguyên tắc hơn là quy tắc ở chỗ bạn có thể rebase những thứ bạn đã push *nếu bạn hiểu hậu quả*. Nhưng thông thường đây không phải là tình huống tốt, vì vậy bạn sẽ muốn thường xuyên tránh nó.

Lý do là rebase *viết lại lịch sử*. Và điều đó khiến lịch sử của bạn không đồng bộ với lịch sử của các dev khác đã clone repo với lịch sử cũ, và việc đồng bộ lại khá khó khăn.

Có các lệnh khác trong Git cũng viết lại lịch sử. Và quy tắc chung là *không bao giờ viết lại lịch sử trên bất cứ thứ gì đã được push*. Trừ khi bạn thực sự biết mình đang làm gì.

## So Sánh Với Merge

[i[Rebase-->Compared to merging]<]
[i[Merge-->Compared to rebasing]<]

Nhưng trước khi ta hào hứng chạy đi nói về rebase, hãy ôn lại nhanh về merge. Đây là biến thể của một ví dụ trước khi ta có hai branch phân kỳ, Figure_#.1. Giả sử bạn đang làm việc trên branch `topic`.

![Two divergent branches.](img_110_010.pdf "Two divergent branches.")

Sau đó bạn nghe rằng ai đó đã thay đổi `main` và bạn muốn tích hợp những thay đổi đó vào branch `topic`, nhưng chưa muốn đưa thay đổi của mình vào `main`.

Tại thời điểm này, nếu ta muốn đưa các thay đổi trong `main` vào `topic`, tùy chọn merge của ta là tạo thêm một commit --- _merge commit_. Merge commit chứa các thay đổi từ hai commit cha (trong trường hợp này commit được đánh dấu `(2)` và commit được đánh dấu `(4)` là cha) và tạo thành một commit mới, đánh dấu là `(5)` trong Figure_#.2.

![Two divergent branches, merged.](img_110_020.pdf "Two divergent branches, merged.")

Nếu ta xem log tại thời điểm đó, ta có thể thấy các thay đổi từ tất cả các commit khác trong graph từ branch `topic`.

Và đến đây ta ổn rồi. Điều đó đã hoạt động và làm được những gì ta muốn. Merging là giải pháp hoàn toàn chấp nhận được cho vấn đề này.

Nhưng có một vài nhược điểm khi merge. Thấy không, ta thực sự chỉ muốn lấy nội dung mới nhất từ `main` vào branch của mình để có thể dùng, nhưng ta không thực sự muốn commit bất cứ thứ gì. Nhưng ở đây ta đã tạo một commit mới cho mọi người thấy.

Không những vậy, bây giờ commit graph tạo thành một vòng lặp, vì vậy lịch sử phức tạp hơn một chút so với mong muốn của ta.

Điều thực sự tốt là nếu tôi có thể lấy các commit `(3)` và `(4)` từ `topic` và áp dụng những thay đổi đó lên `(2)` trong `main`. Nghĩa là, liệu ta có thể giả vờ rằng thay vì branch từ `(1)` như `topic` đã làm, ta đã branch từ `(2)` không?

Xét cho cùng, nếu ta branch từ `(2)`, ta sẽ có những thay đổi từ `main` mà ta muốn.

Điều ta cần là một cách nào đó để tuas lại các commit của mình về điểm phân kỳ tại `(1)`, rồi áp dụng lại chúng lên commit `(2)`. Nghĩa là, base của branch `topic`, vốn là commit `(1)`, cần được thay đổi thành một base khác tại commit `(2)`. Ta muốn ***rebase*** nó lên commit `(2)`!

[i[Rebase-->Compared to merging]>]
[i[Merge-->Compared to rebasing]>]

## Cách Hoạt Động

Vậy hãy làm chính xác điều đó. Hãy lấy các thay đổi ta đã thực hiện trong commit `(3)` và áp dụng chúng lên `main` tại commit `(2)`. Điều này sẽ tạo ra một commit hoàn toàn mới bao gồm các thay đổi từ cả commit `(2)` và commit `(3)`. (Quan trọng là commit này chưa tồn tại trước đây; không có commit nào chứa các thay đổi từ `(2)` và `(3)`.) Ta sẽ gọi commit mới này là `(3')` ("ba nháy"), vì nó có các thay đổi mà ta đã thực hiện trong `(3)`.

Sau đó, ta sẽ làm tương tự với commit `(4)`. Ta sẽ áp dụng các thay đổi từ commit cũ `(4)` lên `(3')`, tạo ra commit mới `(4')`.

Và nếu ta làm vậy, ta sẽ có Figure_#.3.

![`topic` branch rebased on `main`.](img_110_030.pdf "topic branch rebased on main")

Và bạn thấy `(3')` và `(4')` bây giờ đã được rebase lên `main`! Và bây giờ branch `topic` bao gồm commit `(2)` từ branch `main`!

Một lần nữa, hai commit này có cùng thay đổi mà bạn ban đầu có trong commit `(3)` và `(4)`, nhưng bây giờ chúng đã được áp dụng lên `main` tại commit `(2)`. Vì vậy code nhất thiết khác vì nó bây giờ chứa các thay đổi từ `main`. Điều này có nghĩa là các commit cũ `(3)` và `(4)` của bạn thực sự không còn nữa, và rebase đã thay thế chúng bằng hai commit mới chứa cùng thay đổi, chỉ là trên một base point khác.

> **Ta vừa thay đổi lịch sử.** Khi ta đề cập đến việc viết lại lịch sử ở
> đầu chương này, đây là điều ta đang nói đến. Hãy tưởng tượng một dev
> khác có các commit cũ `(3)` và `(4)` của bạn và đang làm việc dựa trên
> chúng để tạo commit mới của riêng họ. Và sau đó bạn rebase, thực sự phá
> hủy commit `(3)` và `(4)`. Bây giờ lịch sử commit của bạn khác với lịch
> sử của dev kia và mọi thứ *Thú Vị*™ sẽ xảy ra khi cố gắng sắp xếp lại.
>
> Nếu bạn chỉ rebase các commit mà bạn chưa push, bạn sẽ không bao giờ
> gặp rắc rối. Nhưng nếu một dev khác có bản sao commit của bạn (vì bạn đã
> push và họ đã pull), đừng rebase những commit đó!

## Khi Nào Nên Làm Điều Này?

[i[Rebase-->When to use]]
Không có quy tắc cố định về điều này. Đôi khi một nhóm sẽ có quy tắc, nói rằng mọi người nên rebase mọi lúc để lịch sử commit trông sạch sẽ hơn (không có merge commit, không có vòng lặp).

Các nhóm khác sẽ nói luôn luôn merge để lịch sử đầy đủ được bảo toàn.

## Pull và Rebase

[i[Rebase-->And pulling]<]

Nếu bạn còn nhớ từ trước, pull thực sự là một vài thao tác: [i[Fetch]] *fetch* và *merge*.

Fetch tải xuống tất cả dữ liệu mới từ remote, nhưng không thực sự merge bất cứ thứ gì vào branch hay working tree của bạn. Vậy bạn sẽ không thấy bất kỳ thay đổi cục bộ nào sau fetch.

Nhưng pull theo sau nó bằng một merge tiêu chuẩn để bạn thấy các thay đổi của remote tracking branch trong branch cục bộ của mình.

Vậy, giả sử bạn đã thiết lập mọi thứ và đang ở branch `main`, khi bạn làm thế này:

``` {.default}
$ git pull
```

Git thực sự làm điều gì đó như thế này:

[i[Fetch]]

``` {.default}
git fetch                # Get all the information from origin
git merge origin/main    # Merge origin/main into main
```

(Nhớ rằng `origin/main` là remote-tracking branch của bạn --- đó là phiên bản `main` trên `origin`, không phải `main` trên máy cục bộ của bạn.)

Nhưng merge không phải là thứ duy nhất bạn có thể làm ở đó. Vì đây là chương về rebase, bạn có thể đúng khi nghi ngờ rằng ta có thể làm nó thực hiện rebase thay thế.

Và đây là cách:

``` {.default}
$ git pull --rebase
```

Lệnh đó sẽ làm hai điều sau:

[i[Fetch]]

``` {.default}
git fetch                # Get all the information from origin
git rebase origin/main   # Rebase main into origin/main
```

Nếu bạn muốn đó là hành vi mặc định cho repo hiện tại, bạn có thể chạy lệnh một lần này:

``` {.default}
$ git config pull.rebase true
```

Nếu bạn muốn nó là hành vi mặc định cho tất cả repo, bạn có thể:

``` {.default}
$ git config --global pull.rebase true
```

Nếu bạn đã cấu hình repo để luôn rebase khi pull, bạn có thể ghi đè điều đó để buộc merge (nếu muốn) với:

``` {.default}
$ git pull --no-rebase  # Do a merge instead of a rebase
```

[i[Rebase-->And pulling]>]

## Conflict {#rebasing-conflicts}

[i[Rebase-->Conflicts]<]

Khi bạn merge, có khả năng bạn sẽ conflict với một số thay đổi trong branch kia, và bạn phải giải quyết chúng, như ta đã thấy.

Điều tương tự có thể xảy ra với rebase không?

Tất nhiên! Nếu commit bạn đang cố rebase lên conflict với commit của bạn, bạn sẽ gặp rắc rối tương tự như với merge.

May mắn thay, Git sẽ cho bạn giải quyết conflict theo cách tương tự như merge.

Hãy bắt đầu với một ví dụ đơn giản. Tôi sẽ có một file text chứa nội dung sau:

``` {.default}
The magic number is 1.
```

Ta sẽ có nó trong một commit trên branch `main`.

Sau đó ta sẽ tạo branch `topic` mới từ đó.

Trên branch `main` ta sẽ đổi số thành `2` và commit.

Và trên branch `topic` ta sẽ đổi số thành `3` và commit.

Vậy ta sẽ có kịch bản trong Figure_#.4.

![Branches ready for conflict.](img_110_040.pdf "Branches ready for conflict")

Cuối cùng, ta sẽ cố rebase `topic` lên `main`.

Tại thời điểm đó, Git sẽ bị bối rối. Nó biết commit cuối trên `main` có `2` và `topic` không biết điều này (vì nó đã branch trước thay đổi đó). Và nó biết commit cuối trên `topic` có `3`. Vậy cái nào đúng?

Hãy thử rebase khi đang ở branch `topic` và xem điều gì xảy ra.

``` {.default}
$ git rebase main
  Auto-merging magic.txt
  CONFLICT (content): Merge conflict in magic.txt
  error: could not apply 9f19221... Update to 3
  hint: Resolve all conflicts manually, mark them as resolved with
  hint: "git add/rm <conflicted_files>", then run "git rebase
  hint: --continue".
  hint: You can instead skip this commit: run "git rebase --skip".
  hint: To abort and get back to the state before "git rebase", run
  hint: "git rebase --abort".
  hint: Disable this message with "git config advice.mergeConflict
  hint: false"
  Could not apply 9f19221... Update to 3
```

Ôi trời. OK, vậy nó không thể làm điều đó. Nó bảo ta cần "Resolve all conflicts manually" (giải quyết tất cả conflict thủ công), rồi add chúng, rồi ta sẽ chạy rebase lại với flag `--continue` để tiếp tục rebase.

> **Nếu bạn tiếp tục đọc các gợi ý**, bạn sẽ thấy còn có thêm thứ nữa.
> Ta sẽ đến `--skip` sau, nhưng lưu ý rằng nếu conflict quá phức tạp để
> xử lý ngay lúc này, bạn có thể chạy:
>
> ``` {.default}
> $ git rebase --abort
> ```
>
> <!-- ` -->
> để giả vờ như bạn chưa bao giờ bắt đầu nó.

Điều này có thể nghe quen quen. Về cơ bản đó là quy trình tương tự như ta đã trải qua với merge conflict.

1. Chỉnh sửa file có conflict và làm cho nó *Đúng*.
2. Add nó.
3. Tiếp tục rebase.

Hãy làm vậy. Nếu tôi mở file `magic.txt` trong editor, tôi thấy:

``` {.default .numberLines}
<<<<<<< HEAD
The magic number is 2
=======
The magic number is 3
>>>>>>> 9f19221 (Update to 3)
```

Giống hệt như trong merge conflict --- Git đang hiển thị cho ta hai lựa chọn cho dòng này. Vậy ta sẽ tham khảo ý kiến nhóm và đi đến thống nhất về nội dung file, rồi xóa tất cả những gì không cần và làm cho nó *Đúng*.

``` {.default}
The magic number is 3
```

Và tôi lưu lại.

Bây giờ, ta cần làm gì ở thời điểm này nhỉ? Nếu bạn quên, không sao. Chỉ cần chạy `git status` để xem tình trạng.

``` {.default}
$ git status
  interactive rebase in progress; onto 6ceeefb
  Last command done (1 command done):
     pick 9f19221 Update to 3
  No commands remaining.
  You are currently rebasing branch 'topic' on '6ceeefb'.
    (fix conflicts and then run "git rebase --continue")
    (use "git rebase --skip" to skip this patch)
    (use "git rebase --abort" to check out the original branch)
  
  Unmerged paths:
    (use "git restore --staged <file>..." to unstage)
    (use "git add <file>..." to mark resolution)
	  both modified:   magic.txt
  
  no changes added to commit (use "git add" and/or "git commit -a")
```

À phải! `--continue` đấy nhỉ?

``` {.default}
$ git rebase --continue
  magic.txt: needs merge
  You must edit all merge conflicts and then
  mark them as resolved using git add
```

Sao vậy? Ồ, ta nên đọc thêm phần status. Nó bảo dùng `git add` để đánh dấu file `magic.txt` đã được giải quyết. Hãy làm vậy.

``` {.default}
$ git add magic.txt
$ git status
  interactive rebase in progress; onto 6ceeefb
  Last command done (1 command done):
     pick 9f19221 Update to 3
  No commands remaining.
  You are currently rebasing branch 'topic' on '6ceeefb'.
    (all conflicts fixed: run "git rebase --continue")

  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  modified:   magic.txt
```

Status đó trông ổn hơn. (Nhưng lưu ý rằng Git đang ở trạng thái "rebase" đặc biệt tương tự như khi nó vào trạng thái "merge" đặc biệt khi merge. Ta phải hoặc là abort hoặc continue trước khi có thể dùng Git bình thường.)

Bây giờ `--continue`.

``` {.default}
$ git rebase --continue
```

Lệnh này đưa tôi vào editor để chỉnh sửa commit message. Đây là cơ hội để bạn thay đổi commit message nếu nó không còn phản ánh commit nữa. (Nghĩa là nếu bạn thay đổi commit khi giải quyết conflict thành thứ gì đó hoàn toàn khác, bạn có thể cần sửa message.) Chỉnh sửa nếu cần và lưu lại.

Và Git báo:

``` {.default}
[detached HEAD 443fa53] Update to 3
 1 file changed, 1 insertion(+), 1 deletion(-)
Successfully rebased and updated refs/heads/topic.
```

Và `git status` cho thấy tất cả đã rõ ràng.

Sau tất cả những điều đó, ta thấy commit graph mới của mình trong Figure_#.5.

![After rebase conflict resolution.](img_110_050.pdf "After rebase conflict resolution.")

Một lưu ý cuối: nếu bạn thấy mình giải quyết cùng các conflict khi rebase lần nào cũng vậy mỗi lần pull, bạn có thể xem xét [i[`git rerere`]] [fl[`git rerere`|https://git-scm.com/book/en/v2/Git-Tools-Rerere]] để giúp tự động hóa quá trình đó.

[i[Rebase-->Conflicts]>]

## Squash Commit {#squashing-commits}

[i[Rebase-->Squashing commits]<]

Khái niệm này liên quan đến ý tưởng về lịch sử commit sạch sẽ.

Giả sử bạn được giao nhiệm vụ triển khai một tính năng, cụ thể là thêm hộp cảnh báo thông báo vượt giới hạn lưu trữ.

Không vấn đề gì. Bạn thêm nó và commit với message "Added feature #121". (Và bạn chưa push.)

``` {.default}
alert("Strrage limit exceeeded");
```

Rồi sau khi commit, bạn nhận ra có lỗi đánh máy. Chết thật.

Vậy bạn sửa và commit với message "Fixed typo" (Sửa lỗi đánh máy).

``` {.default}
alert("Storage limit exceeeded");
```

Xong.

Đợi đã! Còn một lỗi đánh máy nữa! Bạn đùa tôi à?

Vậy bạn sửa nó:

``` {.default}
alert("Storage limit exceeded");
```

Và thêm một commit nữa với message "Fixed another typo" (Sửa thêm lỗi đánh máy).

Bây giờ lịch sử commit cục bộ của bạn là:

``` {.default}
Fixed another typo
Fixed a typo
Added feature #121
```

Không được sạch sẽ lắm phải không? Thực ra đây đáng lẽ phải là một commit duy nhất triển khai feature #121.

Nhưng may mắn thay bạn chưa push, có nghĩa là bạn vẫn tự do viết lại lịch sử đó!

Bạn có thể dùng tính năng của rebase gọi là ***squashing*** (ép gộp) để thực hiện điều này.

Những gì bạn muốn làm là squash hai commit sửa lỗi đánh máy đó vào commit trước, commit mà bạn lần đầu cố triển khai tính năng.

Đầu tiên, hãy xem log.

``` {.default}
$ git log
commit c1820e6d0da19013208b389d264310162477b099 (HEAD -> main)
Author: User <user@example.com>
Date:   Wed Jul 17 11:53:10 2024 -0700

    Fixed another typo

commit c62c0db7b82e6b415d36bd0f00d568fd503164b7
Author: User <user@example.com>
Date:   Wed Jul 17 11:53:10 2024 -0700

    Fixed typo

commit ab84a428b8baae0078ee0647a67b34a89a6abed8
Author: User <user@example.com>
Date:   Wed Jul 17 11:53:10 2024 -0700

    Added feature #121

commit a95854659e31d203e2325eee61d892c9cdad767c
Author: User <user@example.com>
Date:   Wed Jul 17 11:53:10 2024 -0700

    Added
```

Vì đây là rebase, ta sẽ rebase lên thứ gì đó, cụ thể là commit _trước_ commit added feature, commit ID bắt đầu bằng `a9585`.

Và ta muốn làm theo chế độ _interactive_ (tương tác), đây là chế độ rebase đặc biệt cho phép ta thực hiện squashing, và ta đến đó bằng flag `-i`.

``` {.default}
$ git rebase -i a9585
```

Lệnh này đưa ta vào editor với thông tin này, và một khối comment khổng lồ bên dưới chứa đầy hướng dẫn.

``` {.default .numberLines}
pick ab84a42 Added feature #121
pick c62c0db Fixed typo
pick c1820e6 Fixed another typo
```

Lưu ý rằng chúng được liệt kê theo thứ tự tiến, thay vì thứ tự log ngược mà ta quen.

Nhìn tất cả các tùy chọn được hiển thị trong khối comment (và không hiển thị ở đây trong hướng dẫn)! Pick, reword, edit, squash, fixup... quá nhiều thứ để chọn. Như bạn có thể tưởng tượng, ta đang ở chế độ viết lại lịch sử rất mạnh mẽ.

Nhưng bây giờ, hãy chỉ xem "squash" và "fixup", hai cái gần như giống nhau.

Bắt đầu với "squash", điều tôi muốn làm là lấy các commit sửa lỗi đánh máy và gộp chúng vào commit "Added feature". Ta có thể dùng chế độ squash để làm điều này.

Tôi sẽ chỉnh sửa file để trông như thế này:

``` {.default .numberLines}
pick ab84a42 Added feature #121
squash c62c0db Fixed typo
squash c1820e6 Fixed another typo
```

Lệnh đó sẽ squash "Fixed another typo" vào "Fixed typo" và sau đó squash kết quả đó vào "Added feature #121".

Và `pick` chỉ có nghĩa là "dùng commit này như hiện tại".

> **Có các phiên bản viết tắt cho tất cả các lệnh này.** Tôi có thể dùng
> `s` thay vì `squash`.

Sau khi tôi lưu file, tôi ngay lập tức được đưa vào một editor khác có nội dung này:

``` {.default .numberLines}
# This is a combination of 3 commits.
# This is the 1st commit message:

Added feature #121

# This is the commit message #2:

Fixed typo

# This is the commit message #3:

Fixed another typo
```

Ta đang tạo một commit mới được rebase với ba commit được squash thành một, vì vậy ta được viết commit message mới. Hữu ích thay, Git đã đưa vào tất cả ba commit message. Hãy rút gọn nó xuống chỉ còn commit message ta muốn.

``` {.default .numberLines}
Added feature #121
```

Và lưu lại sẽ đưa ta ra với một thông báo.

``` {.default}
[detached HEAD 4bc6bca] Added feature #121
 Date: Wed Jul 17 11:53:10 2024 -0700
 1 file changed, 1 insertion(+)
 create mode 100644 foo.js
Successfully rebased and updated refs/heads/main.
```

Thành công là tốt. Tôi thích thành công.

> **Cái gì đó về detached HEAD?** Git tạm thời tách `HEAD` khi thực hiện
> rebase. Đừng lo --- nó sẽ được gắn lại cho bạn.

Bây giờ lịch sử commit của tôi đã được dọn sạch.

``` {.default}
commit 4bc6bca6870d124b3eebc9afd32486a5a23189fc (HEAD -> main)
Author: User <user@example.com>
Date:   Wed Jul 17 11:53:10 2024 -0700

    Added feature #121

commit a95854659e31d203e2325eee61d892c9cdad767c
Author: User <user@example.com>
Date:   Wed Jul 17 11:53:10 2024 -0700

    Added
```

Và bạn có thể thấy, nếu nhìn vào log trước đó, rằng commit ID của "Added feature" đã thay đổi. Ta đã rebase, sau cùng, vì vậy những commit cũ đó đã biến mất, được thay thế bởi những commit mới.

Cuối cùng, sau tất cả điều này, *bây giờ* bạn có thể push. Và luôn nhớ rằng vì đây là viết lại lịch sử, bạn không nên làm vậy sau khi đã push.

[i[Rebase-->Squashing commits]>]

### Squash vs Fixup

[i[Rebase-->Fixup]]

Bây giờ một lưu ý nhanh về `fixup` thay vì `squash`. Nó giống nhau, ngoại trừ chỉ commit message của commit được squash vào được giữ theo mặc định. Vậy nếu tôi chạy thế này:

``` {.default .numberLines}
pick fbc1075 Added feature #121
fixup fd4ca42 Fixed typo
fixup 6a10e97 Fixed another typo
```

Git lập tức trả về:

``` {.default}
Successfully rebased and updated refs/heads/main.
```

Và git log chỉ hiển thị commit "Added feature #121". Với `fixup`, Git tự động bỏ các commit message đã được squash.

## Nhiều Conflict trong Rebase

[i[Rebase-->Conflicts]<]

Khi bạn merge với commit và có nhiều conflict, bạn giải quyết tất cả trong một merge commit lớn rồi xong. Bạn dùng `git commit` để kết thúc.

Rebase thì khác một chút. Vì rebase "replay" (phát lại) các commit của bạn lên base mới từng cái một, mỗi lần replay là một cơ hội xảy ra merge conflict. Điều này có nghĩa là *khi bạn rebase, bạn có thể phải giải quyết nhiều conflict liên tiếp*.

Ví dụ, giả sử trên branch topic của bạn bạn đã thực hiện một commit sửa đổi file `foo.txt`. Và sau đó bạn thực hiện *một commit khác* sửa đổi file `bar.txt`.

Nhưng không biết rằng, ai đó trên branch `main` cũng đã sửa đổi hai file đó, vì vậy chúng sẽ conflict khi bạn rebase.

Và vì vậy bạn bắt đầu `git rebase main`, và ta gặp rắc rối ngay từ đầu. Nó báo cho ta biết `foo.txt` có conflict.

Vậy bạn sửa nó rồi chạy `git rebase --continue` và chỉnh sửa commit message, và tiếp tục.

Nhưng tất cả những điều đó chỉ chuyển sang *commit tiếp theo* của bạn cho `bar.txt` và cố rebase nó. Và nó cũng có conflict!

Vậy bạn sửa nó rồi chạy `git rebase --continue` và chỉnh sửa commit message, và tiếp tục. Lại một lần nữa.

Và cuối cùng bạn nhận được thông báo thành công:

``` {.default}
[detached HEAD 31c3947] topic change bar
 1 file changed, 1 insertion(+)
Successfully rebased and updated refs/heads/topic.
```

Đây là lý do tại sao bạn có thể kết thúc merge bằng một commit đơn giản, nhưng bạn phải kết thúc rebase bằng cách chạy `git rebase --continue` nhiều lần cho đến khi tất cả commit được rebase sạch sẽ.

Điều này tốt hay xấu? Có thể tốt hơn ở chỗ bạn có cơ hội merge từng commit một cách độc lập nên có thể dễ suy luận hơn và tránh lỗi. Nhưng đồng thời nó cũng nhiều công hơn để hoàn thành.

Như thường lệ, hãy dùng công cụ phù hợp cho công việc!

[i[Rebase-->Conflicts]>]

[i[Rebase]>]
