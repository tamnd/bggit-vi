# Reset: Di Chuyển Nhánh {#reset}

[i[Reset]<]

Trước khi bắt đầu, sử dụng `git reset` sẽ ***rewrite history*** (viết lại lịch
sử). Điều đó có nghĩa là bạn không nên dùng nó trên bất kỳ nhánh nào mà người
khác có thể có bản sao, tức là các nhánh bạn đã push.

Tất nhiên, đây là hướng dẫn nên làm, không phải quy tắc bắt buộc, và bạn có thể
reset bất cứ thứ gì miễn là bạn biết mình đang làm gì và có giao tiếp tốt với
nhóm.

Nhưng nếu bạn reset một nhánh chưa push, bạn sẽ không gặp rắc rối.

Vậy reset là gì?

Thực hiện reset cho phép bạn thay đổi vị trí `HEAD` và nhánh hiện tại đang trỏ
đến. Bạn có thể di chuyển nhánh hiện tại đến một commit khác!

Khi bạn di chuyển nhánh đến commit khác, nhánh đó "trở thành" repo tại thời điểm
commit đó, bao gồm toàn bộ lịch sử dẫn đến commit đó. Kết quả là tất cả các
commit dẫn đến điểm nhánh cũ giờ đây thực sự biến mất, như trong Hình 19.1.

![Nếu chúng ta reset `main` về commit _2_, các commit _3_ và _4_ cuối cùng sẽ bị mất.](img_150_010.pdf "If we reset main to commit 2, commits 3 and 4 will eventually be lost.")

Vậy hãy chắc chắn bạn thực sự muốn khi reset! Bạn sẽ mất các commit[^d563]!

[^d563]: Git dọn dẹp các commit "không thể truy cập" sau một khoảng thời gian,
    vì vậy chúng sẽ không bị *phá hủy ngay lập tức*. Nhưng chúng đang sống
    trong thời gian vay mượn trừ khi bạn tạo nhánh mới để giữ chúng.

Khi thực hiện reset, bạn có thể yêu cầu Git di chuyển nhánh hiện tại đến commit
khác, hoặc đến nhánh khác, hoặc đến bất cứ thứ gì xác định một commit.

Giờ có câu hỏi về điều gì xảy ra với *sự khác biệt* giữa working tree của bạn
tại commit cũ và nó sẽ là gì tại commit mới.

Bạn có thể đọc câu đó quá nhanh, nên hãy xem lại vì nó quan trọng. Ngay lúc
này, bạn có một số file trong working tree. Hãy giả sử bạn đã commit đầy đủ và
`HEAD` đang ở nhánh `main`. Bây giờ nếu bạn di chuyển nhánh `main` đến nơi
khác, *nhất thiết sẽ có sự khác biệt giữa những gì bạn có ở commit bạn* đang
*xem, và commit bạn* sẽ *xem.

Chúng ta cần quyết định làm gì với sự khác biệt đó. Nó sẽ được phản ánh ở đâu?
Như sự khác biệt giữa stage và commit đích? Sự khác biệt giữa working tree và
stage? Hay cả hai?

Hóa ra chúng ta có ba lựa chọn: ***soft reset*** (reset mềm), ***mixed reset***
(reset hỗn hợp), và ***hard reset*** (reset cứng).

Và lựa chọn của bạn kiểm soát điều gì xảy ra với nhánh, stage, và working tree.

> **Tôi muốn bạn nghĩ rằng *tất cả* các file tồn tại ở ba nơi cùng lúc trong
> Git:** working tree, stage, và một commit.
>
> Và bạn sẽ nói, "Khoan---stage có *tất cả* các file trên đó? Nhưng tôi chưa
> add gì vào đó!"
>
> Đúng vậy. Ý tôi là khi working tree của bạn sạch, điều đó có nghĩa là các
> file trong commit `HEAD`, các file trên stage, và các file trong working tree
> *đều giống nhau*. Và vâng, tất cả các file tồn tại ở cả ba nơi![^12db]
>
> [^12db]: Ai biết nó thực sự làm gì bên dưới, nhưng chúng ta sẽ dùng cái này
>     làm mô hình tư duy về cách mọi thứ hoạt động.
>
> Và `git status` sẽ không hiển thị gì cả vì không có sự khác biệt nào giữa ba
> nơi này. Và `git status` hiển thị các sự khác biệt.
>
> Giả sử bạn chỉnh sửa một file trong working tree. Trong trường hợp đó, `git
> status` sẽ cho bạn thấy sự khác biệt giữa working tree và stage là một "file
> được chỉnh sửa". Nhưng vẫn chưa có sự khác biệt nào giữa stage và commit
> `HEAD`, nên không có gì hiển thị là "ready to commit".
>
> Rồi giả sử bạn add file vào stage. Lúc này, bản sao của file từ working tree
> được đặt trên stage. Vậy giờ working tree và stage giống nhau. Và không có gì
> hiển thị là "modified". Nhưng giờ, quan trọng là, stage khác với commit
> `HEAD`! Vậy giờ `git status` hiển thị sự khác biệt đó là "ready to commit".
>
> Cuối cùng, giả sử trước khi commit, bạn lại chỉnh sửa file trong working tree.
> Giờ file trong working tree khác với stage. **Và** file trên stage khác với
> commit `HEAD`! Giờ file hiển thị cả "ready to commit" lẫn "modified".
>
> Lý do tôi muốn chúng ta suy nghĩ theo cách này là vì nó sẽ giúp toàn bộ vấn
> đề với `git reset` dễ tiêu hóa hơn. Đôi khi reset sẽ thay đổi các file trong
> working tree, đôi khi trên stage, và đôi khi cả hai.

Lưu ý: trong các ví dụ tiếp theo, tôi sẽ dùng thuật ngữ "commit cũ" để chỉ vị
trí nhánh *trước* reset, và "commit mới" để chỉ vị trí nó sẽ là *sau* reset.

Với cả ba biến thể, nhánh hiện tại di chuyển đến commit mới (đã chỉ định).

Tóm tắt sự khác biệt:

* **Soft**:
  * Stage: commit cũ
  * Working tree: commit cũ
  * Kết quả: Tất cả các file cũ sẽ hiển thị trên stage là "ready to commit".

* **Mixed**:
  * Stage: commit mới
  * Working tree: commit cũ
  * Kết quả: Tất cả các file cũ sẽ hiển thị trong working tree là "modified".
  
* **Hard**:
  * Stage: commit mới
  * Working tree: commit mới
  * Kết quả: Tất cả các file cũ sẽ biến mất, và working tree và stage sẽ sạch.

## Soft Reset

[i[Reset-->Soft]<]

Khi bạn chạy `git reset --soft`, thao tác này reset nhánh hiện tại trỏ đến
commit đã cho, và làm cho stage và working tree đều có các thay đổi tồn tại trong
commit cũ.

Kết quả là `git status` sẽ hiển thị các thay đổi của commit cũ là đã staged, và
không có file nào là modified.

Nói cách khác, bạn sẽ thấy trạng thái cũ của các file trên stage sẵn sàng
commit.

Cách dùng phổ biến cho điều này là để gộp một số commit trước đây tương tự như
những gì chúng ta đã làm với [rebase và squashing commits](#squashing-commits).

Giả sử chúng ta có các commit như thế này (hãy coi số là commit hash):

``` {.default}
commit 555 (HEAD -> main)
   Fixed another typo again
commit 444
   Fixed another typo
commit 333
   Fixed a typo
commit 222
   Implemented feature
commit 111
   Added
```

Lịch sử commit trông khá rối rắm. Sẽ hay hơn nếu viết lại nó (*nhưng nếu và
chỉ nếu bạn chưa push nó!*).

Chúng ta có thể làm điều đó với soft reset về commit `111`.

Nếu chúng ta thực hiện soft reset này:

``` {.default}
$ git reset --soft 111   # Again, pretend 111 is the commit hash
```

Chúng ta sẽ ở trạng thái này với tất cả các commit khác đã biến mất...

``` {.default}
commit 111 (HEAD -> main)
   Added
```

**Nhưng quan trọng là** các file của chúng ta *như chúng tồn tại trong commit
555* giờ sẽ được staged và sẵn sàng commit. Điều đó có nghĩa là với soft reset,
các thay đổi không bị mất, mà thực tế các commit 222-555 đều bị gộp lại trên
stage.

Vậy chúng ta commit chúng:

``` {.default}
$ git commit -m "Implemented feature"
```

Và giờ chúng ta ở đây với lịch sử commit đẹp:
 
``` {.default}
commit 222 (HEAD -> main)
   Implemented feature
commit 111
   Added
```

Và giờ cuối cùng chúng ta có thể push, vui vẻ vì những thay đổi của mình được
trình bày tốt cho công chúng.

> **Một lần nữa, chúng ta đã viết lại lịch sử ở đây.** Đừng làm điều này nếu
> bạn đã push những commit đó vượt qua commit bạn đang reset về.

[i[Reset-->Soft]>]

## Mixed Reset

[i[Reset-->Mixed]<]

Trước khi bắt đầu, trường hợp sử dụng chính của reset này trước đây là để unstage
(bỏ stage) các file. Giờ lệnh hiện đại hơn là `git restore --staged`, và bạn nên
dùng cái đó nếu tất cả những gì bạn muốn là unstage.

Nhưng vẫn xem nó hoạt động như thế nào nào!

Khi bạn chạy `git reset --mixed`[^2472], thao tác này reset nhánh hiện tại trỏ
đến commit đã cho, nó chỉnh sửa stage về commit đó, và **không** thay đổi working
tree của bạn.

[^2472]: Bạn có thể bỏ qua `--mixed` vì đó là mặc định.

Kết quả là nó sẽ hiển thị các file là "modified" với những thay đổi của commit
cũ, và sẽ không có gì trên stage.

Bây giờ, suy nghĩ về điều này, vì nhánh đã di chuyển đến commit với các file của
bạn ở một trạng thái, nhưng working tree có các file ở trạng thái khác, các file
phải là *modified* so với commit mà nhánh giờ trỏ đến.

Và đây là điều xảy ra. Các thay đổi của bạn tại commit cũ sẽ hiển thị là các
file modified tại commit hiện tại.

Giống như soft reset, ngoại trừ thay vì commit cũ kết thúc trên stage, nó kết
thúc trong working tree. Bạn có thể stage nó và commit từ đây.

Nhưng đó chưa phải tất cả! Vì stage cũng được cập nhật về commit mới, điều đó
có nghĩa là stage thực sự bị "làm trống".

Như tôi đã đề cập, đây là cách dùng kinh điển cho mixed reset: `git reset HEAD`.
Thao tác này di chuyển file từ trạng thái staged về trạng thái modified.

Nó sẽ reset nhánh hiện tại về nơi nó đã là (giả sử `HEAD` trỏ đến nhánh hiện
tại), và reset stage về cùng commit đó. Điều này unstage các file đang ở đó.
Và nó thay đổi các file working tree để có những thay đổi đã tồn tại trong các
file đó tại điểm đó, tức là bất kỳ thay đổi nào bạn đã đưa vào.

Và điều đó unstage các file!

Cách dùng khác có thể là nếu bạn muốn squash một loạt commit chưa push nhưng
đơn giản là chưa muốn stage các thay đổi tại commit cũ, để chúng là modified.

[i[Reset-->Mixed]>]

## Hard Reset

[i[Reset-->Hard]<]

Cái này reset mọi thứ về một commit cụ thể. Nhánh di chuyển đến đó. Stage được
đặt về commit đó. Các file trong working tree được đặt về commit đó. Tất cả các
thay đổi kể từ commit đó đều bị mất.

Dùng cái này nếu bạn muốn thoát ra. Bạn đã thực hiện một số commit và quyết
định đó là sai hướng, và bạn muốn đơn giản là roll back (quay ngược) chúng hoàn
toàn.

**Một lần nữa, chỉ làm điều này nếu bạn chưa push!**

Nếu bạn thực hiện hard reset, nó sẽ đơn giản là di chuyển nhánh và reset toàn
bộ thế giới của bạn (liên quan đến nhánh đó) về điểm đó như thể không có gì xảy
ra kể từ đó. `git status` sẽ báo cáo rằng mọi thứ đều sạch sẽ.

[i[Reset-->Hard]>]

## Reset về Nhánh Phân Kỳ

[i[Reset-->To divergent branch]<]

Trong các ví dụ trên, chúng ta đã reset về tổ tiên trực tiếp của commit hiện tại.
Đây là trường hợp phổ biến khi dùng `git reset`.

Nhưng không có lý do gì bạn không thể reset về một nhánh phân kỳ hoàn toàn khác.
Nó chỉ di chuyển nhánh đến đó với chính xác các quy tắc về soft, mixed, và hard
mà chúng ta đã đề cập.

[i[Reset-->To divergent branch]>]

## Reset File

[i[Reset-->Files]<]

Cho đến nay, chúng ta chỉ thực hiện reset trên cơ sở commit-by-commit (từng
commit). Nhưng chúng ta cũng có thể thực hiện mixed reset với các file cụ thể.
Tuy nhiên, chúng ta không thể thực hiện hard hay soft reset với các file cụ thể
---tiếc thay!

Ví dụ, chúng ta có thể thực hiện mixed reset để unstage một file duy nhất.

Giả sử chúng ta ở đây:

``` {.default}
$ git status
  On branch main
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  modified:   bar.txt
	  modified:   foo.txt
```

Và chúng ta muốn reset `foo.txt` khỏi stage, nhưng để `bar.txt` ở đó.

> **Một lần nữa, chúng ta sẽ dùng `git restore --staged` trong thời hiện đại.**
> Nhưng chúng ta sẽ tiếp tục ở đây cho mục đích ví dụ.

Vậy hãy chỉ định file đó:

``` {.default}
$ git reset foo.txt
  Unstaged changes after reset:
  M	foo.txt

$ git status
  On branch main
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  modified:   bar.txt

  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working
    directory)
	  modified:   foo.txt
```

Và đây rồi.

[i[Reset-->Files]>]

## Push Thay Đổi Nhánh lên Remote

[i[Reset-->Pushing to remote]<]

Giả sử bạn đã làm rối tung mọi thứ và bạn phải reset một nhánh mà bạn đã push
commit lên. Tức là bạn phải viết lại lịch sử công khai.

***Đầu tiên: giao tiếp tốt với nhóm.*** Họ chắc chắn sẽ trêu bạn, nhưng ít
nhất họ sẽ không ghét bạn[^d100].

[^d100]: Không có gì đảm bảo. Bạn không nên viết lại lịch sử commit đã công
    khai!! Nó tạo ra mớ hỗn độn lớn!

> ***Đừng bao giờ thực hiện forced push mà không hiểu hoàn toàn *lý do* tại
> sao bạn làm vậy.*** Git đang cố ngăn bạn push vì một lý do: vì lợi ích của
> bạn! Tất cả mọi người khác đã clone repo sẽ rất có thể bị ảnh hưởng và họ
> cần được thông báo. Mọi người. Chúng ta dùng nó ở đây để minh họa khi nào
> nó là cần thiết.

Quy trình của chúng ta sẽ như thế này:

1. Thực hiện reset.
2. Thực hiện forced push lên remote của bạn. Vì sự bảo vệ của bạn, Git sẽ không
   push trong hoàn cảnh này. Bạn phải override (ghi đè) với forced push.

Đồng nghiệp của bạn sẽ làm gì đó như thế này:

1. [i[Fetch]]Thực hiện `git fetch` để lấy vị trí nhánh mới từ remote.
2. Stash hoặc commit bất kỳ thay đổi local nào họ cần giữ lại.
3. Có thể tạo nhánh mới tại điểm nhánh cũ phòng trường hợp họ cần quay lại xem
   các commit cũ sắp bị xóa.
4. Thực hiện reset nhánh đang xét về commit nhánh remote. Ví dụ, nếu chúng ta
   đang reset nhánh `main`, bạn sẽ `git reset --hard origin/main`.
5. Pop thay đổi từ stash ra, nếu có.
6. Có thể áp dụng lại các commit cũ đã bị xóa[^318a].

[^318a]: Có thể dùng `git reflog` và `git cherry-pick` hoặc `git cherry-pick -n`
    và tiềm năng `git add -p`, tất cả đều được đề cập trong các chương sau.
    Cùng với việc sử dụng khéo léo rebase, các commit cũ hoặc phần của commit
    cũ có thể được áp dụng trong khi giữ lịch sử commit sạch sẽ.

Lưu ý rằng đồng nghiệp của bạn không nhất thiết phải thực hiện hard reset; họ
có thể thực hiện mixed reset chẳng hạn.

[i[Reset-->Pushing to remote]>]

### Forced Push

[i[Push-->Forced]<]

Về cơ bản chúng ta có hai lựa chọn để dùng với `git push` ở đây:

1. `--force`: Chỉ push vị trí nhánh mới, [flw[damn the
   torpedoes|Battle_of_Mobile_Bay#"Damn_the_torpedoes"]] (mặc kệ hậu quả).
2. `--force-with-lease`: Chỉ force push nếu vị trí nhánh remote là như chúng ta
   mong đợi. Nói cách khác, **đừng** force push nếu ai đó đã push commit mới
   trong thời gian đó. Đây là biện pháp an toàn tốt vì không ai nên đã push
   commit mới trong thời gian đó vì bạn đã giao tiếp với nhóm về điều này.
   ***Phải không?***

Nếu bạn cố `--force-with-lease` và ai đó đã push commit khác vào nhánh này trong
thời gian đó, bạn sẽ thấy lỗi:

``` {.default}
$ git push --force-with-lease
  To git@github.com:user/repo.git
   ! [rejected]        main -> main (stale info)
  error: failed to push some refs to 'git@github.com:user/repo.git'
```

Nếu điều đó xảy ra, bạn sẽ phải nói chuyện với nhóm để họ dừng lại, rồi pull
các thay đổi về, đảm bảo mọi người đồng ý với reset mới, rồi bắt đầu lại.

Chúng ta sẽ dùng `--force-with-lease` trong các ví dụ.

### Ví Dụ: Viết Lại Lịch Sử Công Khai

Đầu tiên, hãy đóng vai người đang viết lại lịch sử công khai.

***Điều đầu tiên tôi sẽ làm là phối hợp với nhóm.*** Nếu bạn đã qua điểm này,
hãy làm ngay **bây giờ**.

Sau đó chúng ta sẽ bắt đầu viết lại. Chúng ta sẽ ở nhánh `main` cho demo này.
Hãy reset về commit cũ hơn, và chúng ta sẽ giả sử những commit chúng ta đang
reset qua đã công khai và các thành viên nhóm khác đã có chúng.

``` {.default}
$ git reset --hard 4849e6
  HEAD is now at 4849e65 added line 3
```

Cho đến nay chưa có hại, nhưng giờ chúng ta sẽ push thay đổi lịch sử này lên
origin. Và chúng ta sẽ dùng `--force-with-lease` để an toàn.

``` {.default}
$ git push --force-with-lease
  To git@github.com:user/repo.git
   + a2b7ac3...ce44516 main -> main (forced update)
```

Giờ chúng ta đã viết lại lịch sử công khai. Thông báo cho nhóm, mà bạn đã liên
lạc suốt thời gian này, rằng bạn đã làm vậy. Và họ có thể bắt đầu sửa các bản
clone của mình với nhiều lời càu nhàu.

### Ví Dụ: Nhận Lịch Sử Đã Được Viết Lại

Bạn vừa nhận được thông báo từ đồng nghiệp rằng lịch sử công khai trên nhánh
`main` đã được viết lại và push lên remote, mà chúng ta sẽ giả sử là `origin`
cho ví dụ này.

Điều đầu tiên chúng ta nên làm là đảm bảo tất cả đều được backup theo cách nào
đó.

Có thể commit những thứ mới nhất:

``` {.default}
$ git add [all files]
$ git commit -m "last commit before public reset"
```

Hoặc stash nếu chúng ta chưa sẵn sàng commit:

``` {.default}
$ git stash
```

Và có thể tạo nhánh mới ngay đây để chúng ta có thể xem lại trạng thái cũ để
tham khảo nếu cần:

``` {.default}
$ git branch oldmain
```

Và giờ là lúc hành động. [i[Fetch]] Chúng ta cần fetch (tải về) thông tin nhánh
mới.

``` {.default}
$ git fetch origin
  From git@github.com:user/repo.git
   + e7b133a...521a873 main       -> origin/main  (forced update)
```

Chúng ta vừa fetch, nên bản clone của chúng ta vẫn chưa thấy khác. Nhưng hãy
chấm dứt điều đó và đồng bộ với `origin`. Điều này liên quan đến việc reset
`main` local của chúng ta để giống như nó ở trên remote tracking branch
`origin/main`. (Nhớ rằng cái sau đã được force push đến commit khác, và chúng
ta muốn `main` của mình cũng trỏ đến commit đó.)

Giả sử chúng ta đang ở nhánh `main` lúc này:

``` {.default}
$ git reset --hard origin/main
```

Và giờ chúng ta đồng bộ với `origin`.

Nếu chúng ta đã stash thứ gì đó, hãy thử lấy lại, giải quyết xung đột như
thường:

``` {.default}
$ git stash pop
```

Và nếu bạn muốn tham khảo bất kỳ commit cũ nào và bạn đã thiết lập nhánh
`oldmain` như trên, bạn có thể `git switch oldmain` để xem chúng, và có thể
dùng `git cherry-pick` để mang vào bất kỳ chức năng nào bạn cần.

[i[Push-->Forced]>]

## Reset mà Không Di Chuyển `HEAD`

[i[Branch-->Moving]<]

Sử dụng tính năng reset di chuyển `HEAD` theo cách bắt buộc. Nếu bạn chỉ muốn
di chuyển nhánh đến commit khác nhưng để `HEAD` yên?

Có thể làm được! Nhưng bạn không thể làm với nhánh bạn đang checkout lúc này.
Vậy hãy detach HEAD hoặc gắn nó vào nhánh khác.

Thay vì dùng `git reset` để làm điều này, chúng ta sẽ dùng `git branch`. Ví dụ:

``` {.default}
$ git switch topic1
  Switched to branch 'topic1'

$ git log
  commit 97c4da49eda8de7b273003515a660945c (HEAD -> topic1)
  Author: User <user@example.com>
  Date:   Thu Aug 1 14:22:39 2024 -0700

      fix a third typo

$ git branch --force main
$ git log
  commit 97c4da49eda8de7b273003515a660945c (HEAD -> topic1, main)
  Author: User <user@example.com>
  Date:   Thu Aug 1 14:22:39 2024 -0700

      fix a third typo
```

Thấy điều gì đã xảy ra với `main` không? Nó di chuyển đến commit hiện tại! Bạn
có thể thấy nó trong output của `git log` thứ hai.

Bạn cũng có thể chỉ định đích đến cho `main` như đối số thứ hai nếu bạn muốn nó
di chuyển đến nơi khác ngoài vị trí hiện tại của bạn.

[i[Branch-->Moving]>]

## Reset để Xóa Thông Tin Xác Thực

Bạn có vô tình commit password bí mật vào repo không? Bạn có thể dùng `git reset`
để hoàn tác commit đó không?

* Bạn đã push chưa? Thì **KHÔNG**. Password của bạn đã ra ngoài. Hãy thay đổi
  nó ngay bây giờ và đừng bao giờ mắc lỗi đó nữa.
* Bạn *chưa push*? **Có**. Bạn có thể làm. Nhưng hãy nhớ rằng commit chứa
  password sẽ vẫn còn trong repo local của bạn cho đến khi nó bị garbage
  collected (thu hồi).

Nếu câu trả lời là có, bạn có thể thấy `git reset -p` hữu ích để reset có chọn
lọc một phần commit, điều mà chúng ta sẽ đề cập trong chương sau.

[i[Reset]>]
