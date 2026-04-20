# Remote: Repo ở Những Nơi Khác

[i[Remote]<]

Một _remote_ (máy chủ từ xa) chỉ đơn giản là một cái tên cho một máy chủ từ xa mà bạn có thể clone, push, và pull từ đó.

Ta xác định những máy chủ này bằng URL. Với GitHub, đây là URL ta đã sao chép khi lần đầu clone repo.

Dùng URL trực tiếp để chỉ định máy chủ trong công việc Git hàng ngày là được, nhưng gõ cả cái URL dài đó thật phiền não. Vì vậy ta đặt biệt danh cho các URL máy chủ từ xa và thường gọi là "remote".

Một remote mà ta đã thấy nhiều rồi là [i[Remote-->`origin`]] `origin`. Đây là biệt danh của repo từ xa mà bạn đã clone về, và Git tự động đặt tên này khi bạn clone.

## Ký Hiệu Remote và Branch

[i[Remote-->Remote branches]<]

Trước khi bắt đầu, lưu ý rằng Git dùng ký hiệu gạch chéo để chỉ một branch cụ thể trên một remote cụ thể: `remotename/branchname`.

Ví dụ, cái này chỉ branch `main` trên remote tên là `origin`:

``` {.default}
origin/main
```

Còn cái này chỉ branch tên `feature3490` trên remote tên `nitfol`:

``` {.default}
nitfol/feature3490
```

Ta sẽ nói thêm về điều này trong chương Remote Tracking Branches.

[i[Remote-->Remote branches]>]

## Xem Danh Sách Remote

[i[Remote-->Listing]<]

Bạn có thể chạy `git remote` với tùy chọn `-v` trong bất kỳ thư mục repo nào để xem những remote mà repo đó có:

``` {.default}
$ git remote -v
  origin    https://github.com/example-repo.git (fetch)
  origin    https://github.com/example-repo.git (push)
```

Ta thấy rằng ta đang dùng cùng một URL cho remote tên `origin` cho cả pull (trong đó có phần `fetch`) và push. Dùng cùng URL cho cả hai là rất phổ biến.

Và URL đó chính xác là cái ta đã sao chép từ GitHub khi clone repo ban đầu.

[i[Remote-->Listing]>]

## Thay Đổi URL của Remote

[i[Remote-->Setting the URL]<]

Nhớ rằng tên remote chỉ là một bí danh cho URL nào đó mà bạn đã clone repo về.

Giả sử bạn đã thiết lập xong SSH key để dùng GitHub cho cả push lẫn pull, nhưng bạn vô tình clone repo bằng URL HTTPS. Trong trường hợp đó, bạn sẽ thấy remote như sau:

``` {.default}
$ git remote -v
origin    https://github.com/example-repo.git (fetch)
origin    https://github.com/example-repo.git (push)
```

Và rồi bạn thử push, GitHub báo rằng bạn không thể push lên remote HTTPS... bực quá!

Bạn đáng lẽ phải sao chép URL SSH khi clone, trông giống như thế này với tôi:

``` {.default}
git@github.com:beejjorgensen/git-example-repo.git
```

May mắn thay, đây chưa phải là tận thế. Ta chỉ cần thay đổi URL mà bí danh đó trỏ tới.

(Ví dụ bên dưới được chia thành hai dòng cho khỏi quá rộng so với trang sách, nhưng bạn có thể viết trên một dòng. Dấu gạch chéo ngược cho Bash biết rằng lệnh còn tiếp tục.)

``` {.default}
$ git remote set-url origin \
             git@github.com:beejjorgensen/git-example-repo.git
```

Và bây giờ khi xem lại remote, ta thấy:

``` {.default}
$ git remote -v
origin    git@github.com:beejjorgensen/git-example-repo.git (fetch)
origin    git@github.com:beejjorgensen/git-example-repo.git (push)
```

Và giờ ta có thể push rồi! (Giả sử SSH key đã được thiết lập.)

[i[Remote-->Setting the URL]>]

## Thêm Remote

[i[Remote-->Adding]<]

Không có gì ngăn bạn thêm một remote khác.

Một ví dụ phổ biến là khi bạn _fork_ một dự án GitHub (sẽ nói thêm sau). Fork là một tính năng của GitHub cho phép bạn dễ dàng clone repo công khai của người khác vào tài khoản của mình, và cung cấp cách tiện lợi để chia sẻ những thay đổi bạn làm với repo gốc.

Giả sử tôi đã fork repo mã nguồn Linux. Khi tôi clone fork đó, tôi sẽ thấy các remote này:

``` {.default}
origin    git@github.com:beejjorgensen/linux.git (fetch)
origin    git@github.com:beejjorgensen/linux.git (push)
```

Tôi không có quyền truy cập vào mã nguồn Linux thật sự, nhưng tôi có thể fork nó và lấy bản sao repo của riêng mình.

Bây giờ, nếu Linus Torvalds thực hiện thay đổi trong repo của ông, tôi sẽ không tự động thấy chúng. Vì vậy tôi muốn có cách nào đó để lấy các thay đổi của ông về và merge vào repo của mình.

Tôi cần một cách để tham chiếu đến repo của ông, vì vậy tôi sẽ thêm một remote tên `reallinux` trỏ đến nó:

``` {.default}
$ git remote add reallinux https://github.com/torvalds/linux.git
```

Bây giờ danh sách remote của tôi trông như thế này:

``` {.default}
origin    git@github.com:beejjorgensen/linux.git (fetch)
origin    git@github.com:beejjorgensen/linux.git (push)
reallinux    https://github.com/torvalds/linux.git (fetch)
reallinux    https://github.com/torvalds/linux.git (push)
```

> [i[Remote-->`upstream` convention]]
> Thông thường khi thiết lập remote trỏ đến repo nguồn của một fork trên
> GitHub, người ta hay gọi remote đó là `upstream`, trong khi tôi đã đặt
> tên là `reallinux`.
>
> Tôi làm vậy vì khi ta sẽ nói về [remote tracking
> branches](#remote-tracking-branch), ta sẽ dùng "upstream" với nghĩa
> khác, và tôi không muốn hai khái niệm này gây nhầm lẫn.
>
> Chỉ cần nhớ rằng trong thực tế khi bạn thiết lập remote trỏ đến repo
> gốc mà bạn đã fork, thường thì người ta đặt tên remote đó là `upstream`.

[i[Remote-->Sync with `upstream`]]

Bây giờ tôi có thể chạy lệnh này để lấy tất cả thay đổi từ repo của Linus:

``` {.default}
$ git fetch reallinux
```

Và tôi có thể merge nó vào branch của mình (repo Linux dùng `master` thay vì `main` cho branch chính):

``` {.default}
$ git switch master            # My local master
$ git merge reallinux/master   # Note the slash notation!
```

Lệnh đó sẽ merge branch `master` từ `reallinux` vào branch `master` cục bộ của tôi, sau khi ta đã xử lý xong mọi conflict.

Nếu tôi thực hiện thêm một commit, `HEAD` và `master` cục bộ của tôi sẽ chuyển đến commit đó, còn `origin/master` (fork của tôi trên GitHub) và `reallinux/master` (repo của Linus) sẽ ở lại phía sau.

Giả sử cho vui tôi đã tạo hai commit mà tôi chưa có trên remote `origin` ở GitHub. Trong trường hợp đó, một log đã cắt bớt và dựng lên cho mục đích minh họa có thể trông như thế này:

``` {.default}
commit 2d7d5d (HEAD -> master)
commit cde831
commit 311eb3 (origin/master)
commit d5d2cc (reallinux/master)
```

Lúc này tôi sẽ `git push` để gửi các thay đổi `master` cục bộ lên GitHub và đưa `origin/master` lên ngang. Vậy commit trên cùng sẽ hiện:

``` {.default}
commit 2d7d5d (HEAD -> master, origin/master)
commit cde831
commit 311eb3
commit d5d2cc (reallinux/master)
```

Và `reallinux/master` sẽ vẫn ở lại phía sau đó. (Và nó sẽ ở đó mãi cho đến khi Linus nhã ý merge các thay đổi của tôi.)

Thú vị phải không, khi `master` cục bộ của tôi có thể không đồng bộ với `master` trên `origin`?

Ta sẽ xem xét điều này trong [chương Remote Tracking Branches](#remote-tracking-branch).

[i[Remote-->Adding]>]

[i[Remote]>]
