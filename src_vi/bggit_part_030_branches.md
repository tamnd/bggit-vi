# Branches và Fast-Forward Merges

## Branch là gì?

[i[Branch]<]

Thông thường bạn nghĩ về việc viết code như một chuỗi thay đổi tuyến
tính. Bạn bắt đầu với một file trống, thêm vào một số thứ, kiểm tra
chúng, thêm nữa, kiểm tra thêm, và cuối cùng code hoàn chỉnh.

![A simple commit graph.](img_030_010.pdf "[A simple commit graph.]")

<!--
``` {.default}
    (1)---(2)---(3)---(4)---(5)
```
-->

Trong Git chúng ta có thể nghĩ về điều này như một chuỗi các commit.
Hãy nhìn vào một đồ thị (Figure_#.1) trong đó mình đã đánh số các commit
từ 1-5. Ở đó, `(1)` là commit đầu tiên chúng ta thực hiện trên repo,
`(2)` là một số thay đổi chúng ta thực hiện trên `(1)`, và `(3)` là một
số thay đổi chúng ta thực hiện trên `(2)`, v.v.

Git luôn theo dõi commit parent (cha) cho bất kỳ commit cụ thể nào,
ví dụ nó biết commit parent của `(3)` là `(2)` trong đồ thị trên. Trong
đồ thị này, quan hệ parent được chỉ ra bởi một mũi tên. "Parent của
commit 3 là commit 2", v.v. Hơi khó hiểu vì rõ ràng commit 3 đến _sau_
commit 2 về mặt thời gian, nhưng mũi tên trỏ đến parent, điều này ngược
với quan hệ thời gian của các node.

Một _branch_ (nhánh) giống như một nhãn tên gắn vào một **cụ thể** commit.
Bạn có thể di chuyển nhãn tên xung quanh bằng các thao tác Git khác nhau.

Chúng ta giả định branch mặc định được gọi là [i[Branch-->`main`]] `main`.
Nếu bạn chưa làm vậy, hãy cấu hình branch mặc định của bạn như được
trình bày trong chương [Git Basics](#initial-setup).

![The main branch on a commit.](img_030_020.pdf "[The main branch on a commit.]")

<!--
``` {.default}
                           [main]
                             |
                             v
    (1)---(2)---(3)---(4)---(5)
```
-->

Vì vậy để làm nó đầy đủ hơn một chút, chúng ta có thể hiển thị branch
đó trong Figure_#.2. Đó là branch `main` của chúng ta được gắn vào
commit được gán nhãn `(5)`.

> **Thật hấp dẫn khi nghĩ về toàn bộ chuỗi commit là "branch", nhưng
> tác giả này khuyến nghị chống lại điều đó.** Tốt hơn là nhớ trong
> đầu rằng branch chỉ là một nhãn tên cho một commit duy nhất, và chúng
> ta có thể di chuyển nhãn tên đó xung quanh.

Nhưng Git cung cấp thứ gì đó mạnh mẽ hơn, cho phép bạn (hoặc các cộng
tác viên) theo đuổi nhiều branch đồng thời.

![Lots of branches.](img_030_030.pdf "[Lots of branches.]")

<!--
``` {.default}
               [main]
                 |
                 v    [somebranch]
    (1)---(2)---(8)      |
            \            v
            (3)---(5)---(7)
              \
              (4)---(6)
                     ^
                     |
              [anotherbranch]
```
-->

Vì vậy có thể có nhiều cộng tác viên đang làm việc trên dự án cùng một
lúc.

Và sau đó, khi bạn sẵn sàng, bạn có thể [i[Merge]] _merge_ (gộp) những
branch đó lại với nhau. Trong Figure_#.4, chúng ta đã merge commit 6 và
7 thành một commit mới, commit 9. Commit 9 chứa các thay đổi của cả
commit 7 và 6.

![After merging `somebranch` and `anotherbranch`.](img_030_040.pdf "[After merging somebranch and anotherbranch.]")

<!--
``` {.default}
               [main]
                 |
                 v      [somebranch|anotherbranch]
    (1)---(2)---(8)            |
            \                  v
            (3)---(5)---(7)---(9)
              \               /
              (4)-----------(6)
```
-->

Trong trường hợp đó, `somebranch` và `anotherbranch` đều trỏ đến cùng
một commit. Không có vấn đề gì với điều này.

> **Mình thực ra đơn giản hóa điều này một chút.** Khi bạn merge một
> branch vào branch khác, thực ra chỉ có branch bạn đang merge *vào*
> di chuyển, không phải cả hai. Vì vậy để hai branch trỏ đến cùng một
> commit, bạn sẽ phải làm hai lần merge: `somebranch` vào `anotherbranch`
> và sau đó `anotherbranch` vào `somebranch`. (Hoặc ngược lại.) Và *sau
> đó* chúng sẽ trỏ đến cùng một commit.

Và sau đó chúng ta có thể tiếp tục merge nếu muốn, cho đến khi tất cả
các branch đều trỏ vào cùng một commit (Figure_#.5).

![After merging all branches.](img_030_050.pdf "[After merging all branches.]")

<!--
``` {.default}
                     [main|somebranch|anotherbranch]
                                 |
                                 v
    (1)---(2)---(8)-------------(10)
            \                   /
            (3)---(5)---(7)---(9)
              \               /
              (4)-----------(6)
```
-->

Và có thể sau tất cả những điều này chúng ta quyết định xóa `somebranch`
và `anotherbranch`; chúng ta có thể làm điều này một cách an toàn vì
chúng đã được merge đầy đủ, và có thể làm điều này mà không ảnh hưởng
đến `main` hay bất kỳ commit nào (Figure_#.6).

![After deleting merged branches.](img_030_060.pdf "[After deleting merged branches.]")

<!--
``` {.default}
                               [main]
                                 |
                                 v
    (1)---(2)---(8)-------------(10)
            \                   /
            (3)---(5)---(7)---(9)
              \               /
              (4)-----------(6)
```
-->

Chương này là về việc thành thạo với branching và một phần với merging.

Nếu bạn thích các tutorial tương tác, Peter Cottle đã tạo ra một trang
web tuyệt vời gọi là [fl[Learn Git
Branching|https://learngitbranching.js.org/]]. Mình rất khuyến nghị nó
trước, trong và/hoặc sau khi đọc chương này.

## Ghi Chú Nhanh về `git pull`

[i[Pull-->Force rebase or merge]]

Khi bạn thực hiện pull, nó thực sự làm hai việc: [i[Fetch]] (a) _fetch_
(lấy) tất cả các thay đổi từ remote repo và (b) _merge_ những thay đổi
đó.

Nếu hai hoặc nhiều người đang commit vào cùng một branch, cuối cùng
`git pull` sẽ phải merge. Và hóa ra có một vài cách nó có thể làm điều
này.

Bây giờ, chúng ta sẽ yêu cầu `git pull` luôn merge các branch phân kỳ
theo cách cổ điển, và bạn có thể làm điều đó với lệnh một lần này:

``` {.default}
$ git config set --global pull.rebase false
```

Nếu bạn không làm điều đó, Git sẽ bật lên thông báo lỗi phàn nàn về
nó lần đầu tiên nó phải merge khi pull. Và bạn sẽ phải làm điều đó
khi đó. (Bỏ từ `set` ra khỏi lệnh đó nếu nó thất bại trên các Git cũ
hơn.)

Khi chúng ta nói về [rebasing](#rebase) sau, điều này sẽ có ý nghĩa hơn.

## `HEAD` và Branches

[i[`HEAD`-->With branches]]

Trước đây chúng ta đã nói rằng `HEAD` tham chiếu đến một commit cụ thể,
cụ thể là commit bạn đang nhìn vào ngay bây giờ trong working tree chưa
sửa đổi của bạn.

Và chúng ta cũng nói rằng đó là một lời nói không hoàn toàn đúng.

[i[`HEAD`-->Detached]<]

Trong sử dụng thông thường, `HEAD` trỏ đến một branch, không phải một
commit. Chỉ trong trạng thái detached head thì `HEAD` mới trỏ trực tiếp
đến một commit (tức là khi nó bị tách khỏi tất cả các branch).

Nếu chúng ta nhìn vào Figure_#.7, chúng ta thấy `HEAD` đang trỏ đến
một branch theo bình thường.

![`HEAD` pointing to a branch.](img_030_070.pdf "[HEAD pointing to a branch.]")

<!--
``` {.default}
                     [main]<--HEAD
                       |
                       v
    (1)---(2)---(3)---(4)
```
-->

Nhưng nếu chúng ta check out một commit trước đó không có branch, chúng
ta kết thúc ở trạng thái detached head, và nó trông như Figure_#.8.

![`HEAD` pointing to a commit.](img_030_080.pdf "[HEAD pointing to a commit.]")

<!--
``` {.default}
               HEAD   [main]
                 |     |
                 v     v
    (1)---(2)---(3)---(4)
```
-->

Cho đến nay, chúng ta đã tạo commit trên branch `main` mà không thực sự
nghĩ về branching. Nhớ lại rằng branch `main` chỉ là một nhãn cho một
commit cụ thể, làm thế nào branch `main` biết để "theo" `HEAD` của chúng
ta từ commit sang commit?

Nó làm như thế này: branch mà `HEAD` trỏ đến theo commit hiện tại. Tức
là, khi bạn tạo commit, branch mà `HEAD` trỏ đến di chuyển đến commit
tiếp theo đó.

Nếu chúng ta ở đây tại Figure_#.7, khi `HEAD` đang trỏ đến branch
`main`, chúng ta có thể tạo thêm một commit và đến Figure_#.9.

![`HEAD` moving with a branch.](img_030_090.pdf "[HEAD moving with a branch.]")

<!--
``` {.default}
                           [main]<--HEAD
                             |
                             v
    (1)---(2)---(3)---(4)---(5)
```
-->

So sánh với trạng thái detached head, tại Figure_#.8. Nếu chúng ta ở
đó, một commit mới sẽ đưa chúng ta đến Figure_#.10, để `main` yên.

![A commit with detached `HEAD`.](img_030_100.pdf "[A commit with detached HEAD.]")

<!--
``` {.default}
                      [main]
                       |
                       v
    (1)---(2)---(3)---(4)
                  \
                  (5)
                   ^
                   |
                  HEAD
```
-->

Tại đây, không có gì ngăn bạn tạo một branch mới tại commit giống như
`HEAD`, nếu bạn muốn làm vậy. Hoặc có thể bạn chỉ đang nghịch và quyết
định switch lại `main` sau, từ bỏ các commit bạn đã tạo ở trạng thái
detached `HEAD`.

[i[`HEAD`-->Detached]>]

Bây giờ chúng ta đã trình bày những thứ lý thuyết trừu tượng, hãy nói
cụ thể.

## Liệt Kê Tất Cả Branches Của Bạn

[i[Branch-->Listing]<]

Trước khi bắt đầu, hãy xem cách liệt kê các branch.

``` {.default}
$ git branch
  * main
```

Điều này cho bạn biết có một branch, và bạn đã check out nó (`*` cho
bạn biết điều đó).

Nếu mình tạo một branch mới gọi là `foobranch` và switch sang đó, mình
sẽ thấy điều này:

``` {.default}
% git branch
  * foobranch
    main
```

Nếu sau đó mình detach `HEAD`, mình kết thúc ở đây:

``` {.default}
% git branch              
  * (HEAD detached at 10b6242)
    foobranch
    main
```

Nhưng bạn luôn có thể thấy mình đang ở branch nào với `git branch` hay
`git status`.

[i[Branch-->Listing]>]

## Tạo Một Branch

[i[Branch-->Creating]<]

Khi bạn thực hiện commit đầu tiên vào một repo mới, branch `main` được
tự động tạo cho bạn tại commit đó.

Nhưng còn các branch mới mà chúng ta muốn tạo thì sao?

> **Tại sao lại tạo một branch?** Một trường hợp phổ biến là bạn muốn
> làm việc trên các commit của mình mà không ảnh hưởng đến công việc
> của người khác. (Trong trường hợp này bạn thực sự chỉ trì hoãn công
> việc cho đến khi bạn merge branch với của họ, nhưng đó là một workflow
> tốt.)
>
> Một trường hợp khác là bạn muốn nghịch với một số thay đổi nhưng bạn
> không chắc chúng có hoạt động không. Nếu chúng không hoạt động, bạn
> có thể chỉ cần xóa branch. Nếu chúng hoạt động, bạn có thể merge các
> thay đổi của mình trở lại branch không-nghịch.

Cách phổ biến nhất để tạo branch mới là như sau:

1. Switch sang commit hoặc branch từ đó bạn muốn tạo branch mới.

2. Tạo branch mới ở đó và switch `HEAD` để trỏ đến branch mới.

Hãy thử. Hãy tạo branch từ `main`.

Bạn có thể đã check out `main` rồi (tức là `HEAD` trỏ đến `main`), nhưng
hãy làm lại để an toàn, rồi chúng ta sẽ tạo một branch với `git switch`:

``` {.default}
$ git switch main
$ git switch -c newbranch
```

Thông thường bạn có thể chỉ switch sang một branch khác (tức là có
`HEAD` trỏ đến branch đó) với `git switch branchname`. Nhưng nếu branch
không tồn tại, bạn cần dùng flag `-c` để tạo branch trước khi switch
sang nó.

> **Hãy chắc chắn tất cả các thay đổi local của bạn đã được commit
> trước khi switch branches!** Nếu bạn `git status` nó phải nói "working
> tree clean" trước khi bạn switch. Sau này chúng ta sẽ học về một tùy
> chọn khác khi nói về [stashing](#stash).

Vì vậy sau khi check out `main`, chúng ta có Figure_#.11.

![`HEAD` pointing to `main`.](img_030_070.pdf "[HEAD pointing to main.]")

<!--
``` {.default}
                      [main]<--HEAD
                       |
                       v
    (1)---(2)---(3)---(4)
```
-->

Và sau đó với `git switch -c newbranch`, chúng ta tạo và switch sang
`newbranch`, và điều đó đưa chúng ta đến Figure_#.12.

![`HEAD` pointing to `newbranch`.](img_030_110.pdf "[HEAD pointing to newbranch.]")

<!--
``` {.default}
                      [main]
                       |
                       v
    (1)---(2)---(3)---(4)
                       ^
                       |
                   [newbranch]<--HEAD
```
-->

Không quá thú vị, vì chúng ta vẫn đang nhìn vào cùng một commit, nhưng
hãy xem điều gì xảy ra khi chúng ta tạo một số commit mới trên branch
mới này.

> **Các branch chúng ta đang tạo ở đây chỉ tồn tại trên clone local của
> bạn**; chúng không được tự động truyền lại đến nơi bạn đã clone repo.
>
> Điều đó có nghĩa là nếu bạn vô tình (hoặc cố ý) xóa repo local của
> mình, khi bạn `git clone` lại, tất cả các branch local của bạn sẽ
> biến mất (cùng với bất kỳ commit nào không phải là một phần của `main`
> hay bất kỳ branch nào khác đã được push lên server).
>
> Có một cách để thiết lập kết nối đó nơi các branch local của bạn được
> upload khi bạn push, được gọi là [_remote-tracking
> branches_](#remote-tracking-branch). `main` được kết nối với remote
> tracking branch (thường gọi là `origin/main`) đó là lý do tại sao
> `git push` từ `main` hoạt động trong khi `git push` từ `newbranch`,
> không được kết nối mặc định với remote tracking branch, báo lỗi. Nhưng
> chúng ta sẽ nói tất cả điều này sau.

[i[Branch-->Creating]>]

## Tạo Một Số Commits Trên Một Branch

Điều này không thực sự khác với những gì chúng ta đã làm với các commit
của mình trước đây. Trước khi chúng ta tạo branch, chúng ta có `HEAD`
trỏ đến branch `main`, và chúng ta đã tạo commit trên `main`.

Bây giờ chúng ta có `HEAD` trỏ đến `newbranch` và các commit của chúng
ta sẽ đến đó, thay thế.

Ngay sau khi tạo `newbranch`, chúng ta có tình huống trong Figure_#.12.
Bây giờ hãy chỉnh sửa thứ gì đó trong working tree và tạo một commit
mới. Với điều đó, chúng ta sẽ có tình huống trong Figure_#.13.

![Adding a new commit to `newbranch`.](img_030_120.pdf "[Adding a new commit to newbranch.]")

<!--
``` {.default}
                      [main]
                       |
                       v
    (1)---(2)---(3)---(4)
                       ^
                       |
                   [newbranch]<--HEAD
```

``` {.default}
                      [main]
                       |
                       v
    (1)---(2)---(3)---(4)---(5)
                             ^
                             |
                         [newbranch]<--HEAD
```
-->

Đúng không? Hãy tạo thêm một commit và đến Figure_#.14.

![Adding another commit to `newbranch`.](img_030_130.pdf "[Adding another commit to newbranch.]")

<!--
``` {.default}
                      [main]
                       |
                       v
    (1)---(2)---(3)---(4)---(5)---(6)
                                   ^
                                   |
                               [newbranch]<--HEAD
```
-->

Chúng ta có thể thấy rằng `newbranch` và `main` đang trỏ đến các commit
khác nhau.

> **Nếu chúng ta muốn thấy trạng thái của repo từ góc nhìn của `main`,
> chúng ta phải làm gì?** Chúng ta sẽ phải `git switch main` để nhìn
> vào branch đó.

Bây giờ có một câu hỏi khác. Giả sử chúng ta quyết định hài lòng với
các thay đổi trên `newbranch`, và chúng ta muốn merge chúng vào code
trong branch `main`. Chúng ta sẽ làm điều đó như thế nào?

## Merging: Fast-Forward

[i[Merge]<]
[i[Merge-->Fast-forward]<]

Đưa hai branch trở lại đồng bộ được gọi là _merging_ (gộp).

Branch bạn đang ở là branch bạn đang đưa các thay đổi khác _vào_. Tức
là, nếu bạn đang ở Branch A, và bạn nói với git để "merge Branch B",
các thay đổi của Branch B sẽ được áp dụng vào Branch A. (Branch B vẫn
không thay đổi trong tình huống này.)

Nhưng trong phần này chúng ta sẽ nói về một loại merge cụ thể: _fast-forward_
(tua nhanh). Điều này xảy ra khi branch bạn đang merge từ là một
descendant (hậu duệ) trực tiếp của branch bạn đang merge vào.

Giả sử chúng ta có `newbranch` được check out, như từ ví dụ trước trong
Figure_#.14.

<!--
``` {.default}
                      [main]
                       |
                       v
    (1)---(2)---(3)---(4)---(5)---(6)
                                   ^
                                   |
                               [newbranch]<--HEAD
```
-->

Mình quyết định muốn merge các thay đổi của `main` vào `newbranch`, vì
vậy (một lần nữa, với `newbranch` hiện đang được check out):

``` {.default}
$ git merge main
  Already up to date.
```

Không có gì xảy ra? Điều đó có nghĩa là gì? Vâng, nếu chúng ta nhìn vào
đồ thị commit ở trên, tất cả các thay đổi của `main` đã có trong
`newbranch`, vì `newbranch` là hậu duệ trực tiếp.

Git đang nói, "Này, bạn đã có tất cả các commit đến `main` trong branch
của bạn rồi, vì vậy không có gì để mình làm."

Nhưng hãy đảo ngược lại. Hãy check out `main` rồi merge `newbranch`
vào nó.

``` {.default}
$ git switch main
```

Bây giờ chúng ta đã di chuyển `HEAD` để theo dõi `main`, như được hiển
thị trong Figure_#.15.

![Checking out `main` again.](img_030_140.pdf "[Checking out `main` again.]")

<!--
``` {.default}
                      [main]<--HEAD
                       |
                       v
    (1)---(2)---(3)---(4)---(5)---(6)
                                   ^
                                   |
                               [newbranch]
```
-->

Và `newbranch` **không** phải là ancestor (tổ tiên) trực tiếp của `main`
(nó là descendant). Vì vậy các thay đổi của `newbranch` **chưa** ở trong
`main`.

Vì vậy hãy merge chúng vào và xem điều gì xảy ra (output của bạn có
thể khác nhau tùy thuộc vào file nào được đưa vào merge):

``` {.default}
$ git merge newbranch
  Updating 087a53d..cef68a8
  Fast-forward
   foo.py | 4 +++-
   1 file changed, 3 insertions(+), 1 deletion(-)
```

Và bây giờ chúng ta đang ở Figure_#.16.

![After merging `newbranch` into `main`.](img_030_150.pdf "[After merging newbranch into main.]")

<!--
``` {.default}
                                 [main]<--HEAD
                                   |
                                   v
    (1)---(2)---(3)---(4)---(5)---(6)
                                   ^
                                   |
                               [newbranch]
```
-->

Chờ một chút --- chúng ta không nói là merge `newbranch` vào `main`, như
là lấy những thay đổi đó và gấp chúng vào branch `main` đó sao? Tại sao
`main` di chuyển?

Chúng ta đã nói vậy! Nhưng hãy dừng lại và suy nghĩ về cách điều này
có thể xảy ra trong trường hợp đặc biệt khi branch bạn đang merge _vào_
là ancestor trực tiếp của branch bạn đang merge _từ_.

Trước đây `main` không có commit `(5)` hay `(6)` trong đồ thị ở trên.
Nhưng `newbranch` đã làm công việc thêm `(5)` và `(6)` rồi!

Cách dễ nhất để đưa những commit đó "vào" `main` là đơn giản _fast-forward_
`main` lên đến commit của `newbranch`!

Lại nữa, điều này chỉ hoạt động khi branch bạn đang merge vào là
ancestor trực tiếp của branch bạn đang merge từ.

Mà thôi, bạn hoàn toàn có thể merge các branch không liên quan trực
tiếp như vậy, ví dụ các branch chia sẻ một ancestor chung nhưng cả hai
đều đã phân kỳ từ đó.

Git sẽ tự động fast-forward nếu có thể. Nếu không, nó thực hiện merge
"thực". Và trong khi fast-forward merge không bao giờ dẫn đến _merge
conflict_ (xung đột merge), các merge thông thường thì có thể.

Nhưng đó là một câu chuyện khác chúng ta sẽ đi vào trong chương [Merging
and Conflicts](#merge).

[i[Merge-->Fast-forward]>]
[i[Merge]>]

## Xóa Một Branch

[i[Branch-->Deleting]]

Nếu bạn đã merge xong branch của mình, thật dễ để xóa nó. **Quan trọng
là, điều này không xóa bất kỳ commit nào; nó chỉ xóa "nhãn" branch để
bạn không thể dùng nó nữa**. Bạn vẫn có thể dùng tất cả các commit.

Giả sử chúng ta đã hoàn thành công việc trên branch `topic1` và chúng
ta muốn merge nó vào `main`. Không vấn đề gì:

``` {.default}
$ git commit -m "finished with topic1"   # on topic1 branch
$ git switch main
$ git merge topic1                       # merge topic1 into main
```

Tại thời điểm này, giả sử merge đã hoàn chỉnh, chúng ta có thể xóa
branch `topic1`:

``` {.default}
$ git branch -d topic1
  Deleted branch topic1 (was 3be2ad2).
```

Xong!

> [i[Branch-->Topic]]**Một *topic branch* (branch chủ đề) là cái chúng
> ta gọi là branch local được tạo cho một chủ đề duy nhất như tính năng,
> sửa lỗi, v.v.** Trong tài liệu này mình sẽ đặt tên các branch là
> `topic` theo nghĩa đen để chỉ ra rằng đó chỉ là một branch tùy ý.
> Nhưng trong thực tế bạn sẽ đặt tên topic branch theo tên của những
> gì bạn đang làm, như `bugfix37`, `newfeature`, `experiment`, v.v.

Nhưng nếu bạn đang làm việc trên một branch và muốn từ bỏ nó trước khi
merge nó vào thứ gì đó thì sao? Cho điều đó, chúng ta có tùy chọn chữ
hoa `D` mang tính mệnh lệnh hơn, có nghĩa là "Mình _thực sự_ muốn. Xóa
branch chưa được merge này!"

``` {.default}
$ git branch -D topic1
```

Dùng chữ thường `-d` trừ khi bạn có lý do để làm khác. Ít nhất nó sẽ
cho bạn biết nếu bạn sắp mất tham chiếu đến các commit chưa được merge
của mình, và sau đó bạn có thể ghi đè với `-D` nếu bạn thực sự muốn.

[i[Branch]>]
