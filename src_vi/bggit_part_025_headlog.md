# Git Log và `HEAD`
[i[Log]<]

Khi chúng ta tạo commit vào một Git repo, nó theo dõi mỗi commit đó
trong một log (nhật ký) mà bạn có thể ghé thăm. Hãy cùng nhìn vào đó
ngay bây giờ.

## Một Ví Dụ về Log

Bạn có thể lấy commit log bằng cách gõ `git log`.

Giả sử mình đang ở một repo với một commit duy nhất nơi mình vừa thêm
một file với commit message "Added".

``` {.default}
$ git log
```

tạo ra:

``` {.default}
commit 5a02fede3007edf55d18e2f9ee3e57979535e8f2 (HEAD -> main)
Author: User Name <user@example.com>
Date:   Thu Feb 1 09:24:52 2024 -0800

    Added
```

Nếu mình tạo thêm một commit, chúng ta sẽ có log dài hơn:

``` {.default}
commit 5e8cb52cb813a371a11f75050ac2d7b9e15e4751 (HEAD -> main)
Author: User Name <user@example.com>
Date:   Thu Feb 1 12:36:13 2024 -0800

    More output

commit 5a02fede3007edf55d18e2f9ee3e57979535e8f2
Author: User Name <user@example.com>
Date:   Thu Feb 1 09:24:52 2024 -0800

    Added
```

Lưu ý rằng entry commit gần đây nhất nằm ở đầu output.

## Có Gì trong Log?

Có một vài điều cần chú ý trong log:

* Commit comment (bình luận commit)
* Ngày tháng
* Người dùng đã tạo commit

Ngoài ra, chúng ta có những con số
[fl[hex|https://en.wikipedia.org/wiki/Hexadecimal]] (thập lục phân) khổng
lồ đó sau từ `commit`.

Đây là _commit ID_ (ID commit) hay _commit hash_ (hash commit). Đây là
số duy nhất toàn cầu mà bạn có thể dùng để xác định một commit cụ thể.

Thường bạn không cần biết điều này, nhưng nó có thể hữu ích để quay
ngược thời gian hoặc theo dõi các commit trong các dự án nhiều developer.

Chúng ta cũng thấy một chút ở đầu nói `(HEAD -> main)`. Điều đó là gì?

[i[Log]>]

## Tham Chiếu `HEAD`

[i[`HEAD`]<]

Chúng ta đã thấy rằng mỗi commit có một định danh duy nhất và khó dùng
như thế này:

`5a02fede3007edf55d18e2f9ee3e57979535e8f2`

May mắn thay, có một vài cách để tham chiếu đến các commit bằng các tên
symbolic (tượng trưng) dễ đọc hơn.

`HEAD` là một trong những tham chiếu này. Nó chỉ ra branch hoặc commit
nào bạn đang xem ngay bây giờ trong thư mục con dự án của bạn[^7b00].
Nhớ cách chúng ta đã nói bạn có thể đi xem các commit trước đó không?
Cách bạn làm điều đó là di chuyển `HEAD` đến chúng.

[^7b00]: Mình đang cố hơi một chút ở đây. `HEAD` nhìn vào commit mà
    bạn đã switch đến. Điều này có thể không hoàn toàn giống như những
    gì trong thư mục con dự án của bạn nếu bạn đã sửa đổi một số file
    kể từ khi di chuyển `HEAD` đến commit đó. Commit là một snapshot,
    nhưng snapshot đó không bao gồm các sửa đổi đối với file cho đến
    khi bạn tạo thêm một commit chứa chúng.

> **Chúng ta chưa nói về branches, nhưng `HEAD` thường tham chiếu đến
> một branch.** Mặc định, đó là branch `main`. Nhưng vì chúng ta đang
> đi trước bản thân, mình sẽ chỉ tiếp tục nói rằng `HEAD` tham chiếu
> đến một commit, mặc dù nó thường làm điều đó gián tiếp thông qua một
> branch.
>
> Vì vậy đây là một lời nói không hoàn toàn đúng, nhưng mình hy vọng
> bạn tha thứ.

Một số thuật ngữ: thư mục con Git bạn đang nhìn vào ngay bây giờ và
tất cả các file trong đó được gọi là _working tree_ (cây làm việc). Working
tree là các file khi chúng xuất hiện tại commit được trỏ bởi `HEAD`,
cộng với bất kỳ thay đổi chưa commit nào bạn có thể đã thực hiện.

Vì vậy nếu bạn chuyển `HEAD` sang một commit khác, các file trong
working tree của bạn sẽ được cập nhật để phản ánh điều đó.

> **Quan trọng là, dữ liệu trong các file trong working tree có thể
> khác với dữ liệu trong các file tại commit hiện tại được trỏ bởi
> `HEAD`.** Điều này xảy ra khi bạn đã sửa đổi một file trong working
> tree nhưng chưa commit nó.

Vậy thì, làm sao chúng ta biết `HEAD` đang tham chiếu đến commit nào?
Nó ở ngay đầu log:

``` {.default}
commit 5e8cb52cb813a371a11f75050ac2d7b9e15e4751 (HEAD -> main)
Author: User Name <user@example.com>
Date:   Thu Feb 1 12:36:13 2024 -0800

    More output
```

Chúng ta thấy `HEAD` ngay đó ở dòng đầu tiên, cho biết `HEAD` đang
tham chiếu đến commit với ID:

`5e8cb52cb813a371a11f75050ac2d7b9e15e4751`

Lại một lần nữa, đó là một lời nói không hoàn toàn đúng. `HEAD -> main`
có nghĩa là `HEAD` thực sự đang tham chiếu đến branch `main`, và `main`
đang tham chiếu đến commit. `HEAD` do đó đang gián tiếp tham chiếu đến
commit. Sẽ nói thêm về điều đó sau.

## Quay Ngược Thời Gian và Detached `HEAD`

[i[`HEAD`-->Detached]]

Đây là Git log đầy đủ của mình:

``` {.default}
commit 5e8cb52cb813a371a11f75050ac2d7b9e15e4751 (HEAD -> main)
Author: User Name <user@example.com>
Date:   Thu Feb 1 12:36:13 2024 -0800

    More output

commit 5a02fede3007edf55d18e2f9ee3e57979535e8f2
Author: User Name <user@example.com>
Date:   Thu Feb 1 09:24:52 2024 -0800

    Added
```

Nếu mình nhìn vào các file, mình sẽ thấy các thay đổi được chỉ ra bởi
commit "More output". Nhưng giả sử mình muốn quay ngược thời gian đến
commit trước đó và xem các file trông như thế nào khi đó. Mình sẽ làm
điều đó như thế nào?

> **Có thể có một số thay đổi tồn tại trong commit trước đó** đã bị
> xóa từ đó, và bạn muốn nhìn vào chúng, ví dụ.

Mình có thể dùng lệnh [i[Switch]] `git switch` để làm điều đó xảy ra.

> **Trước khi bạn switch branches, bạn nên commit xong với `git status`
> báo cho bạn biết mọi thứ đã sạch.** Nếu bạn chưa làm vậy, hãy tạo
> commit hoặc [stash](#stash) (cất tạm) những thứ của bạn trước khi
> switch.

Hãy check out commit đầu tiên, cái có ID
`5a02fede3007edf55d18e2f9ee3e57979535e8f2`.

Bây giờ, mình có thể nói:

``` {.default}
$ git switch --detach 5a02fede3007edf55d18e2f9ee3e57979535e8f2
```

và điều đó sẽ hoạt động, nhưng quy tắc là bạn phải chỉ định ít nhất 4
chữ số duy nhất của ID, vì vậy mình cũng có thể đã làm điều này:

``` {.default}
$ git switch --detach 5a02
```

cho kết quả tương tự.

Và kết quả đó là:

``` {.default}
HEAD is now at 5a02fed
```

Hãy nhìn xung quanh với `git log`:

``` {.default}
commit 5a02fede3007edf55d18e2f9ee3e57979535e8f2 (HEAD)
Author: User <user@example.com>
Date:   Thu Feb 1 09:24:52 2024 -0800

    Added
```

Chỉ có vậy thôi! Chỉ một commit?! Commit thứ hai mình đã tạo đâu rồi?
Nó biến mất vĩnh viễn?!

Không. Mọi thứ đều ổn. _[Hình ảnh nhẹ nhàng của một chú mèo con ngủ
dưới nắng.]_

Khi bạn có `HEAD` tại một commit nhất định, bạn đang nhìn vào thế giới
khi nó trông như vậy tại snapshot đó trong thời gian. Các commit tương
lai chưa "xảy ra" từ góc nhìn này. Chúng vẫn ở đó, nhưng bạn sẽ phải
thay đổi lại bằng tên. (Như một cỗ máy _thời gian_ vậy!)

Ngoài ra, bạn có thấy gì khác biệt về dòng đầu tiên đọc `(HEAD)` không?
Đúng: không có `main` nào được thấy.

Đó là vì branch `main` vẫn đang nhìn vào commit mới nhất, cái có comment
"More output". Vì vậy chúng ta không thấy nó từ góc nhìn này.

Hơn nữa, điều này có nghĩa là `HEAD` không còn *gắn* vào `main` nữa.
Chúng ta gọi trạng thái này là [i[`HEAD`-->Detached]] *detached head*
(đầu bị tách). Và `git switch` không cho bạn làm điều đó trừ khi bạn
có ý định, đó là lý do tại sao chúng ta có `--detach` trong đó. (Và
việc reattach (gắn lại) rất dễ: chỉ cần switch sang branch bạn muốn
gắn vào.)

> **Nhớ trước đây khi mình nói rằng đó là lời nói không hoàn toàn đúng
> khi nói `HEAD` trỏ đến một commit?** Vâng, trạng thái detached head
> là trường hợp mà nó thực sự **làm** vậy. Trạng thái detached head
> chỉ là những gì xảy ra khi `HEAD` đang trỏ đến một commit thay vì một
> branch. Để reattach nó, bạn phải thay đổi nó để trỏ đến một branch
> lại.

Hãy reattach `HEAD` vào branch `main`. Có hai tùy chọn:

1. `git switch -`: điều này chuyển sang bất cứ nơi nào chúng ta đã ở
   trước đó, trong trường hợp này là `main`.
2. `git switch main`: điều này chuyển rõ ràng sang `main`.

Hãy thử:

``` {.default}
$ git switch main
  Previous HEAD position was 5a02fed Added
  Switched to branch 'main'
```

Lưu ý không có `--detach` trong `git switch` đó! Chúng ta đang reattach
head, không phải detach nó, vì vậy chúng ta không phải nói với Git chúng
ta biết mình đang làm gì.

> **Đừng lo nếu bạn quên `--detach`.** Git sẽ nói cho bạn biết nếu bạn
> cần nó.
>
> ``` {.default}
> $ git switch 5a02
>   fatal: a branch is expected, got commit '5a02'
>   hint: If you want to detach HEAD at the commit, try again
>         with the --detach option.
> ```

<!-- ` -->

Và bây giờ nếu chúng ta `git log`, chúng ta thấy tất cả các thay đổi
của mình lại:

``` {.default}
commit 5e8cb52cb813a371a11f75050ac2d7b9e15e4751 (HEAD -> main)
Author: User Name <user@example.com>
Date:   Thu Feb 1 12:36:13 2024 -0800

    More output

commit 5a02fede3007edf55d18e2f9ee3e57979535e8f2
Author: User Name <user@example.com>
Date:   Thu Feb 1 09:24:52 2024 -0800

    Added
```

và working tree của chúng ta sẽ được cập nhật để hiển thị các file khi
chúng ở trong commit `main`.

Và bạn thấy `HEAD -> main`? Mũi tên có nghĩa là `HEAD` đã được reattach
vào `main`. (Nếu `HEAD` bị detach ở cùng commit với `main`, bạn sẽ thấy
`HEAD, main`.)

[i[`HEAD`]>]

## Lệnh Cũ: `git checkout`

[i[Checkout]<]

Trong ngày xưa trước khi `git switch` tồn tại, có một lệnh để làm tất
cả những thứ đó gọi là `git checkout`. `git checkout` làm nhiều thứ, và
nó vẫn làm. Vì nó làm nhiều thứ như vậy, những người duy trì Git đã cố
gắng tách một số chức năng đó thành `git switch` và các lệnh khác.

> **Vẫn còn những lúc bạn cần dùng `checkout`**, nhưng nếu phiên bản
> Git của bạn hỗ trợ `switch`, thì đây không phải là lúc đó. Dùng
> `switch` nếu bạn có thể và bỏ qua phần này.

Nhưng hãy làm lại phần trước bằng cách chỉ dùng `git checkout` thay vì
`git switch`. Hãy thử:

``` {.default}
$ git checkout 5a02
```

và nó nói:

``` {.default}
Note: switching to '5a02fede3007edf55d18e2f9ee3e57979535e8f2'.

You are in 'detached HEAD' state. You can look around, make
experimental changes and commit them, and you can discard any
commits you make in this state without impacting any branches by
switching back to a branch.

If you want to create a new branch to retain commits you create, you
may do so (now or later) by using -c with the switch command.
Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead
to false

HEAD is now at 5a02fed Added
```

Ôi thôi, nhiều thứ đáng sợ, nhưng Git chỉ nói với chúng ta rằng chúng
ta bây giờ đang ở trạng thái detached head. Tất nhiên chúng ta có thể
đoán vì chúng ta vừa tách head khỏi branch `main` bằng cách switch sang
một commit hash cụ thể.

Và chúng ta có thể quay lại branch `main` với:

``` {.default}
$ git checkout main
```

Bạn cũng có thể switch lại với các biến thể `git switch` đã đề cập
trước đó, nhưng chúng ta đang giả vờ những cái đó không tồn tại cho
phần này.

[i[Checkout]>]

## Commits Tương Đối với `HEAD`

[i[`HEAD`-->Commits relative to]]

Có một vài phím tắt để đến các commit sớm hơn `HEAD`, như "Mình muốn
switch sang commit thứ 3 trước cái này."

Đây là một ví dụ khá vô dụng mà chúng ta sẽ bắt đầu:

[i[Switch]]

``` {.default}
$ git switch --detach HEAD
```

Điều này di chuyển `HEAD` đến nơi `HEAD` đang ở. Tức là, nó không di
chuyển đến đâu cả. (Mặc dù nó có tác dụng detach nó khỏi branch.)

Nhưng nếu mình muốn di chuyển đến commit ngay *trước* nơi `HEAD` đang
ở bây giờ thì sao? Bạn có thể làm với ***caret notation*** (ký hiệu mũ)
như thế này:

``` {.default}
$ git switch --detach HEAD^
```

Và điều đó đưa bạn đến commit trước đó.

> **Đây là Fun Fact™ ít được biết đến là bạn thường có thể nhập `@`
> thay vì `HEAD` với các lệnh này.** Ví dụ, lệnh trước có thể được viết:
>
> ``` {.default}
> $ git switch --detach HEAD^
> $ git switch --detach @^     # Same thing
> ```
>
> <!-- ` -->
> Lưu ý rằng một số shell có thể yêu cầu bạn đặt `@` trong dấu nháy
> để nó hoạt động đúng. Nhưng điều đó có thể tiết kiệm ba lần gõ phím.

Nếu bạn muốn đến commit _thứ ba trước_ thì sao? Bạn có thể thêm nhiều
mũ hơn!

``` {.default}
$ git switch --detach HEAD^^^
```

Hoặc commit thứ 10 trước!

``` {.default}
$ git switch --detach HEAD^^^^^^^^^^
```

Hoặc commit thứ 100 trước!

``` {.default}
$ git switch --detach HEAD^^^^^^^^^^^^^^^^^^^^forget this
```

Gõ tất cả những mũ này làm mình mệt. May mắn thay, có *thêm* một
shorthand (viết tắt) khác mà chúng ta có với ***tilde notation*** (ký
hiệu ngã). Hai dòng sau đây là tương đương:

``` {.default}
$ git switch --detach HEAD^^^
$ git switch --detach HEAD~3
```

Sau dấu ngã, bạn chỉ cần cho số commit bạn muốn quay lại. Vì vậy quay
lại ví dụ của mình:

``` {.default}
$ git switch --detach HEAD~100   # Much easier
```

Nói tất cả những điều đó, cá nhân mình thường chỉ nhìn vào log và đến
một commit cụ thể thay vì đếm ngược.

> *"But that's just, like, my opinion, man."*\
> \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ---The Dude
