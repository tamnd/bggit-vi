# Stash: Tạm Thời Cất Thay Đổi Sang Một Bên {#stash}

[i[Stash]<]

Nếu bạn đang giữa chừng làm gì đó và nhận ra bạn muốn pull một số thay đổi về, nhưng bạn chưa sẵn sàng commit vì code của mình vẫn đang chạy không được, `git stash` là bạn của bạn. Nó lấy những thứ bạn đang làm việc và cất chúng sang một bên, đưa working tree về trạng thái của commit cuối.

Vậy các thay đổi của bạn sẽ trông như biến mất --- nhưng đừng lo, chúng đang được cất an toàn và bạn có thể mang chúng trở lại sau.

Sau đó bạn có thể pull những thứ mới về để cập nhật, rồi unstash (lấy lại từ stash) những thứ của mình lên trên đó.

Về mặt tinh thần, nó giống như một mini rebase.

## Ví Dụ

Giả sử ta đã cập nhật theo phiên bản mới nhất.

``` {.default}
$ git pull
```

Tốt. Và ta bắt đầu làm việc. Ta mở file `foo.rs` có sẵn và thêm một số code vào theo thường lệ.

Rồi Chris gọi từ bàn bên cạnh và nói, "Ê chờ đã --- tôi vừa cập nhật quan trọng vào `main` và bạn nên dùng nó!"

Và bạn nghĩ, "Ồ chết, tôi đang giữa chừng làm gì đây." Bạn chưa sẵn sàng commit, nhưng bạn muốn có thay đổi của Chris.

Vậy bạn lưu file rồi chạy lệnh này:

``` {.default}
$ git stash
  Saved working directory and index state WIP on main: c72c245
                                some very descriptive commit message
```

Và nếu bạn để ý, bạn có thể đã thấy file trong editor của mình thay đổi trở lại như trước đây! Các thay đổi của bạn đã được hoàn tác và cất đi!

Nếu bạn git status tại thời điểm này, bạn sẽ thấy:

``` {.default}
$ git status
  On branch main
  Your branch is up to date with 'origin/main'.

  nothing to commit, working tree clean
```

Mọi thứ đã sạch sẽ, nghĩa là bây giờ bạn có thể pull và lấy `main` mới nhất. Vậy bạn làm vậy.

``` {.default}
$ git pull
  remote: Enumerating objects: 5, done.
  remote: Counting objects: 100% (5/5), done.
  remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
  remote: (from 0)
  Unpacking objects: 100% (3/3), 943 bytes | 943.00 KiB/s, done.
  From /home/beej/tmp/origin
     10a8ad6..e286011  main       -> origin/main
  Updating 10a8ad6..e286011
  Fast-forward
   foo.rs | 1 +
   1 file changed, 1 insertion(+)
```

Và bây giờ bạn đã cập nhật.

Ô khoan đã. Ta đang làm gì thế nhỉ? À đúng rồi! Ta đã stash nó! Hãy unstash những thay đổi đó với `pop`:

``` {.default}
$ git stash pop
  Auto-merging foo.rs
  On branch main
  Your branch is up to date with 'origin/main'.

  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working
    directory)
	  modified:   foo.rs

  no changes added to commit (use "git add" and/or "git commit -a")
  Dropped refs/stash@{0} (046ac112f8c02c3dc02984ad71d353a3e5be9a7a)
```

Auto-merging nghe có vẻ tốt. Trông như mọi thứ diễn ra suôn sẻ. Và nếu bây giờ ta xem file, ta sẽ thấy các thay đổi được lấy ra từ stash và áp dụng lại. File `foo.rs` của ta đang ở trạng thái "modified" và sẵn sàng để làm việc tiếp, hoặc add và commit.

## Stack Stash

[i[Stash-->The stack]<]

Nếu bạn quen với [flw[kiểu dữ liệu trừu tượng stack|Stack_(abstract_data_type)]], tai bạn có thể vểnh lên khi đọc `git stash pop`.

Đúng vậy, Git theo dõi các stash trong một stack. Nếu bạn không quen với stack, hãy đọc về nó trước.

* `git stash` push working tree lên stash stack.
* `git stash pop` pop đỉnh stash stack và áp dụng nó vào working tree.
* `git stash list` hiển thị stash stack hiện tại.
* `git stash drop` xóa một entry cụ thể trong stash stack.

Do vậy, tôi có thể `stash`, rồi làm gì đó khác, rồi `stash` lại, và ta sẽ có hai stash trên stack.

``` {.default}
$ git stash list
  stash@{0}: WIP on main: 659b132 added repo1 another line
  stash@{1}: WIP on main: 659b132 added repo1 another line
```

Đỉnh stack là `stash@{0}`.

Nếu tôi chạy `git stash pop` đơn giản, nó sẽ lấy stash ở đỉnh, là index `0`, xóa nó khỏi stack và áp dụng vào working tree.

Nhưng bạn cũng có thể pop theo tên stash nếu muốn pop thứ gì đó từ giữa stack.

``` {.default}
$ git stash pop 'stash@{1}'
$ git stash pop --index 1       # same thing
```

Tương tự `stash drop` sẽ pop đỉnh stack và **không** áp dụng các thay đổi vào working tree, loại bỏ chúng.

Và `stash drop` cũng có thể hoạt động trên một stash cụ thể theo tên nếu bạn muốn bỏ thứ gì đó từ giữa stack.

[i[Stash-->The stack]>]

## Conflict

[i[Stash-->Conflicts]<]

Bây giờ sau khi bạn đã dành nhiều thời gian đọc về conflict khi merge và rebase, bạn có thể bắt đầu lo lắng ở đây.

Nếu tôi stash rồi pull, nhưng khi pop stash lại làm thứ gì đó conflict với các thay đổi tôi đã pull thì sao? Điều đó có thể xảy ra không?

Tất nhiên là có thể. Tuyệt vời thay.

Khi điều đó xảy ra, nó trông như thế này:

``` {.default}
$ git stash pop
  Auto-merging foo.rs
  CONFLICT (content): Merge conflict in foo.rs
  On branch main
  Your branch is up to date with 'origin/main'.

  Unmerged paths:
    (use "git restore --staged <file>..." to unstage)
    (use "git add <file>..." to mark resolution)
	  both modified:   foo.rs

  no changes added to commit (use "git add" and/or "git commit -a")
  The stash entry is kept in case you need it again.
```

Trông giống hệt một merge conflict, và trong editor cũng y chang.

``` {.rs .numberLines}
fn main() {
<<<<<<< Updated upstream
    println!("This is critically fixed");
=======
    println!("This is sorta working");
>>>>>>> Stashed changes
}
```

Bạn có thể thấy các thay đổi đã stash của ta bên dưới chỗ ta đã cố sửa, nhưng sau đó ta thấy nó conflict với sửa của Chris từ upstream.

Vậy ta làm chuyện merge và làm cho nó *Đúng*, chỉnh sửa theo cách ta muốn, rồi lưu lại. Status của ta vẫn chưa sạch sẽ.

``` {.default}
$ git status
  On branch main
  Your branch is up to date with 'origin/main'.

  Unmerged paths:
    (use "git restore --staged <file>..." to unstage)
    (use "git add <file>..." to mark resolution)
	  both modified:   foo.rs

  no changes added to commit (use "git add" and/or "git commit -a")
```

Hãy add nó với `git add` để đánh dấu đã giải quyết.

Lúc này có thể xảy ra một số điều.

1. Nếu bạn chỉ chấp nhận phiên bản đã pull về (nghĩa là loại bỏ các thay đổi xung đột của bạn), sẽ không có gì mới xảy ra. Xét cho cùng, đã có commit trong repo của bạn với phiên bản đó, vì vậy Git đủ thông minh để coi là xong. `git status` báo sạch sẽ.

2. Nếu bạn chấp nhận phiên bản khác với phiên bản đã pull về (nghĩa là bạn giữ một phần hoặc tất cả thay đổi của mình), thì `git status` sẽ báo file đó là modified và staged để commit.

   Nếu bạn chưa sẵn sàng commit lúc này, hãy dùng `git restore --staged` để unstage file. Nó sẽ thay đổi trạng thái về chỉ là modified và bạn có thể tiếp tục làm việc trên nó trước khi commit.

**Trong cả hai trường hợp conflict, stash vẫn còn trong stash!**
Đúng vậy, bạn đã chạy `stash pop`, nhưng khi có conflict, stash vẫn nguyên vẹn và không thực sự được pop.

Nếu bạn xong với nó (và có lẽ là vậy), bạn có thể dùng `git stash drop` để xóa stash cụ thể đó khỏi stack và dọn sạch tất cả.

[i[Stash-->Conflicts]>]

## Stash File Mới

[i[Stash-->New files]]

Nếu bạn đã thêm một file mới vào working tree nhưng nó hiện đang untracked thì sao? Stash có thấy nó không?

Không. Bạn phải add nó trước. Vậy hãy `git add` (nhưng không commit!) rồi stash nó. File mới sẽ biến mất khỏi working tree.

[i[Stash]>]
