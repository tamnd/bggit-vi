# Cherry-Pick: Mang Vào Commit Cụ Thể

[i[Cherry-pick]<]

Giả sử bạn đang làm việc trên `branch1` và bạn đã thực hiện sửa lỗi trên
`branch2`. Bạn chưa sẵn sàng merge _toàn bộ_ thay đổi từ `branch2` vào
`branch1`, nhưng bạn thực sự chỉ muốn lỗi đó được sửa.

May thay, có một cách để làm điều đó! Bạn có thể merge một commit duy nhất vào
nhánh của mình với `git cherry-pick`. Bạn chỉ cần cho nó biết commit nào cần
mang vào.

## Ví Dụ Cherry-Pick

Hãy có một file trên nhánh `main` gọi là `foo.txt` với nội dung sau được lưu
trong commit ban đầu:

``` {.default}
Line 1
Line 2
Line 3
Line 4
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10
```

File thú vị lắm đấy.

Giờ hãy chuyển sang nhánh khác, gọi nó là `branch`, đặt tên thật sáng tạo.

Và trên nhánh này, chúng ta làm vài thứ. Đầu tiên, chúng ta thêm vài dòng vào
cuối và commit.

``` {.default}
Line 1
Line 2
Line 3
Line 4
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10
Branch: Line 101
Branch: Line 102
```

Và sau đó chúng ta thêm một dòng vào giữa, và commit lại.

``` {.default}
Line 1
Line 2
Line 3
Line 4
BRANCH: INSERTED LINE 5
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10
Branch: Line 101
Branch: Line 102
```

**Ngoài ra** hãy tạo nhánh tại đây gọi là `checkpoint` để demo này dễ hơn. Bạn
không *bắt buộc* phải làm điều này, nhưng nó sẽ cho phép chúng ta cherry-pick
commit này bằng tên nhánh thay vì bằng commit hash. Hoặc bạn có thể bỏ qua
bước này và chỉ dùng hash.

``` {.default}
$ git branch checkpoint
```

> **Thao tác này không chuyển nhánh.** Nó chỉ tạo nhánh mới trên commit này.
> `HEAD` vẫn trỏ đến `branch` như trước.

Cuối cùng, hãy thêm vài dòng nữa vào cuối, và commit lần cuối.

Vậy đây là file như nó tồn tại trên `branch`:

``` {.default}
Line 1
Line 2
Line 3
Line 4
BRANCH: INSERTED LINE 5
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10
Branch: Line 101
Branch: Line 102
Branch: Line 103
Branch: Line 104
```

Và hãy nhìn vào log để xem chúng ta có gì:

``` {.default}
commit 9336292f73b4ace717644336f72458681c1bb761 (HEAD -> branch)
Author: Branch User Name <branch-user@example.com>
Date:   Sun Oct 20 13:08:30 2024 -0700

    branch: added line 103-104

commit 407f212f12f79902818431a174706cfdc30d509b (checkpoint)
Author: Branch User Name <branch-user@example.com>
Date:   Sun Oct 20 13:08:30 2024 -0700

    branch: inserted line 5

commit 9533e0bdd5cba7d65401c3180b34b01700a7906e
Author: Branch User Name <branch-user@example.com>
Date:   Sun Oct 20 13:08:30 2024 -0700

    branch: added line 101-102

commit d6953bd746c813f5ba545cf0fd6044fd78e2c617 (main)
Author: User Name <user@example.com>
Date:   Sun Oct 20 13:08:30 2024 -0700

    added
```

Được rồi---đó là phần setup (thiết lập) của demo. Giờ là lúc cherry-pick!

Điều chúng ta muốn làm cho demo là chuyển lại về `main` rồi cherry-pick commit
duy nhất chèn dòng 5 vào giữa. Bạn luôn có thể dùng commit hash của nó (`407f2`)
cho điều này, nhưng chúng ta đã để lại nhánh `checkpoint` đó mà chúng ta có thể
dùng thay thế.

Hãy làm vậy.

``` {.default}
$ git switch main
  Switched to branch 'main'

$ git cherry-pick checkpoint
  Auto-merging foo.txt
  [main 9254663] branch: inserted line 5
   Date: Sun Oct 20 13:08:30 2024 -0700
   1 file changed, 1 insertion(+)
```

Điều đó *lẽ ra* đã mang vào dòng 5 được chèn mới đó, và không có thay đổi nào
khác. Hãy nhìn vào `foo.txt` từ `main`:

``` {.default}
Line 1
Line 2
Line 3
Line 4
BRANCH: INSERTED LINE 5
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10
```

Và đây rồi!

> **Khoan---đó không chỉ là merge thôi à?** Không hẳn! Lưu ý rằng chúng ta đã
> thêm dòng 101-102 trong `branch` *trước khi* chúng ta chèn dòng 5. Vậy mà
> commit trước đó không được phản ánh trong `main`. Chúng ta đã *cherry-pick*
> commit đơn lẻ đó với dòng 5 ra khỏi dòng chảy commit, bỏ qua các commit
> trước và sau nó!

Giờ hãy nhìn vào `git log` trên `main`:

``` {.default}
commit 92546636d05fa85218ca18a0cd705ddc14fa8b64 (HEAD -> main)
Author: Branch User Name <branch-user@example.com>
Date:   Sun Oct 20 13:08:30 2024 -0700

    branch: inserted line 5

commit d6953bd746c813f5ba545cf0fd6044fd78e2c617
Author: User Name <user@example.com>
Date:   Sun Oct 20 13:08:30 2024 -0700

    added
```

Có hai điều tuyệt vời cần lưu ý ở đây:

1. Thông tin tác giả được bảo tồn trong commit message. Lưu ý nó là
   `branch-user@example.com` chứ không phải `user@example.com`, mặc dù người
   sau đã thực hiện cherry-pick. Điều này có thể không hoàn toàn ngạc nhiên,
   ngoại trừ...

2. Commit hash của cherry-pick khác nhau trong `main` so với trong `branch`!
   Trong `branch`, nó là `407f2`, và ở đây là `92546`. Nhưng nó **phải** như vậy
   vì nó có toàn bộ nội dung mới. Tức là, không có commit nào khác trong commit
   graph nơi `foo.txt` trông như thế này, vì vậy nó phải có commit hash
   duy nhất[^5472].

[^5472]: Ngay cả khi các thay đổi giống hệt nhau, commit hash vẫn sẽ khác vì
    hash tính đến tất cả các loại metadata khác.

Nhưng không phải mọi cherry-pick đều diễn ra suôn sẻ như vậy!

## Xung Đột khi Cherry-Pick

[i[Cherry-pick-->Conflicts]<]

Vâng, bạn có thể có xung đột với cherry-pick, tất nhiên rồi. Điều này có thể
xảy ra vì bạn đã thay đổi một số dòng giống với commit bạn đang cherry-pick, hoặc
có thể vì commit được cherry-pick có một số dòng code ngữ cảnh mà bạn không có.

Dù sao, việc giải quyết xung đột diễn ra theo cách rất giống với `merge` hay
`rebase`. Nếu cần, hãy làm quen lại với nội dung từ những chương đó.

Nhưng đến giờ tôi hy vọng quy trình đã quen thuộc. Đầu tiên, làm cho file
_Đúng_, sau đó add nó, và sau đó bạn sẽ _continue_ (tiếp tục, giống như với
`rebase`) bằng `git cherry-pick --continue`. Cứ làm vậy cho đến khi mọi thứ
được merge sạch sẽ.

[i[Cherry-pick-->Conflicts]>]

[i[Cherry-pick]>]
