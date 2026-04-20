# Phụ lục: Lỗi và Những Thông Báo Đáng Sợ

[i[Errors]<]

## Detached Head

[i[`HEAD`-->Detached]<]
[i[Errors-->Detached `HEAD`]<]

Bạn có nhận được thông báo đáng sợ kiểu máy chém này không?

``` {.default}
You are in 'detached HEAD' state. You can look around, make
experimental changes and commit them, and you can discard any
commits you make in this state without impacting any branches by
switching back to a branch.

If you want to create a new branch to retain commits you create,
you may do so (now or later) by using -c with the switch command.
Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead
to false

HEAD is now at 0da5af9 line 1
```

Điều này có nghĩa bạn đã checkout (chuyển đến) một commit trực tiếp thay
vì checkout một branch (nhánh). Tức là `HEAD` của bạn không còn gắn với
branch nào nữa --- nó đang ở trạng thái "detached" (tách rời).

Để thoát khỏi tình trạng này, bạn có thể:

1. Hoàn tác lệnh checkout đã khiến bạn bị tách rời:

   ``` {.default}
   git switch -
   ```

2. Chuyển sang branch khác hoàn toàn:

   ``` {.default}
   git switch main
   ```

3. Tạo branch mới tại đây và checkout nó:

   ``` {.default}
   git switch -c newbranch
   ```

Và giờ `HEAD` của bạn không còn bị tách rời nữa.

[i[`HEAD`-->Detached]>]
[i[Errors-->Detached `HEAD`]>]

## Tên Branch Upstream Không Khớp Branch Hiện Tại

[i[Errors-->Branch name doesn't match]<]

Điều gì xảy ra nếu bạn chạy:

``` {.default}
git branch -c newbranch
```

trong khi thực ra muốn chạy:

``` {.default}
git switch -c newbranch
```

Vì nếu vậy, bạn có thể rơi vào đây:

``` {.default}
fatal: The upstream branch of your current branch does not match
the name of your current branch.  To push to the upstream branch
on the remote, use

    git push origin HEAD:main

To push to the branch of the same name on the remote, use

    git push origin HEAD

To choose either option permanently, see push.default in 'git help
config'.

To avoid automatically configuring an upstream branch when its name
won't match the local branch, see option 'simple' of
branch.autoSetupMerge in 'git help config'.
```

Hãy kiểm tra tên các branch để hiểu chuyện gì đang xảy ra:

``` {.default}
$ git branch -vv
  main      fc645f2 [origin/main] line 2
* newbranch 7c21054 [origin/main: behind 1] line 1
```

Lệnh đó cho ta biết tên branch local và, trong ngoặc vuông, remote-tracking
branch (nhánh theo dõi remote) tương ứng. Có gì lạ không?

Có vẻ `main` ứng với `origin/main`.

Và `newbranch` **cũng** ứng với `origin/main`! Sao vậy?!

À, khi bạn chạy `git branch -c newbranch`, lệnh đó *sao chép* branch hiện
tại (`main` trong ví dụ này) sang branch kia, *kể cả remote-tracking branch
của nó*. Tin xấu đây, vì bạn thực sự muốn `newbranch` liên kết với
`origin/newbranch` mới đúng.

Bạn có vài lựa chọn.

1. Bạn muốn push `newbranch` lên `origin` và theo dõi nó là `origin/newbranch`.

   Làm như này để push và đổi tên remote-tracking branch:

   ``` {.default}
   $ git push -u origin newbranch
   ```

2. Bạn chỉ muốn đây là branch local và không cần đẩy lên remote.

   Trong trường hợp này, chỉ cần bỏ thiết lập upstream:

   ``` {.default}
   $ git branch --unset-upstream newbranch
   ```

[i[Errors-->Branch name doesn't match]>]

## Branch Hiện Tại Không Có Upstream Branch

[i[Errors-->No upstream branch]<]

Đang cố push mà nhận được thông báo này?

``` {.default}
fatal: The current branch topic1 has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin topic1

To have this happen automatically for branches without a tracking
upstream, see 'push.autoSetupRemote' in 'git help config'
```

Điều này chỉ có nghĩa là không có upstream tracking branch (nhánh theo dõi
upstream) nào cho `topic1` --- nó chỉ là branch local.

Nếu bạn muốn push branch này, chỉ cần làm theo hướng dẫn được gợi ý.

Nếu bạn đang push nhầm branch, hãy chuyển sang đúng branch trước.

[i[Errors-->No upstream branch]>]

[i[Errors]>]
