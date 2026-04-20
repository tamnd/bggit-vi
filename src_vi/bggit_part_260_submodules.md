# Submodule (Mô-đun Con) {#submodules}

[i[Submodules]<]

Bạn thực sự không thể có một Git repo _bên trong_ một Git repo khác. Ý tôi là, bạn có thể tạo ra nó, nhưng khi thử thêm nó vào repo ngoài, Git sẽ có rất nhiều điều để nói.

``` {.default}
warning: adding embedded git repository: inner
hint: You've added another git repository inside your current
hint: repository. Clones of the outer repository will not contain
hint: the contents of the embedded repository and will not know how
hint: to obtain it. If you meant to add a submodule, use:
hint:
hint: 	git submodule add <url> inner
hint:
hint: If you added this path by mistake, you can remove it from the
hint: index with:
hint:
hint: 	git rm --cached inner
hint:
hint: See "git help submodule" for more information.
hint: Disable this message with "git config advice.addEmbeddedRepo
hint: false"
```

Vậy có lẽ không phải thứ bạn muốn, nhưng Git gợi ý: có thể bạn muốn làm gì đó với submodule!

Submodule cho bạn cách tạo một repo hoàn toàn riêng biệt xuất hiện bên trong working tree của repo hiện tại. Không chỉ vậy, nó còn cho phép working tree hiện tại có một commit cụ thể của submodule được đại diện trong cây submodule đó.

Trường hợp điển hình là khi dự án của bạn phụ thuộc vào một thư viện mà bạn cũng có mã nguồn. Bạn có thể đưa repo của thư viện vào làm submodule trong repo của mình, và hiệu quả là ghim nó vào một phiên bản cụ thể (cụ thể là một commit cụ thể).

Ví dụ, có thể code của bạn hoạt động với FooLib phiên bản 3.4.90. Vì vậy bạn đưa FooLib vào làm submodule và đảm bảo nó được ghim vào phiên bản đó. Rồi dù một team khác có thể đang cập nhật FooLib, bạn sẽ luôn có phiên bản 3.4.90 để build.

Sau này khi sẵn sàng, bạn có thể cập nhật submodule lên phiên bản mới nhất, giả sử 4.0.1, và ghim cái đó vào.

Điều quan trọng cần lưu ý là submodule chỉ là một Git repo thông thường khác. Không có gì đặc biệt cả. Điều duy nhất đáng chú ý là chúng ta đã quyết định clone nó vào trong một repo khác, và liên kết logic nó với repo đó.

## Dùng Repo Có Submodule

Hãy bắt đầu bằng cách nói về những gì xảy ra khi bạn clone một repo đã dùng submodule. Trong trường hợp này, người khác đã thực hiện công việc tập hợp repo cùng submodule, nhưng bạn phải làm thêm một chút sau khi clone để lấy tất cả submodule.

Sau này chúng ta sẽ nói về cách thêm submodule vào dự án.

May mắn thay, để minh họa, tôi có một repo bạn có thể clone đã có submodule được định nghĩa trong đó. (Fork repo trước khi clone nếu bạn muốn có khả năng push lại.)

Giả sử bạn đã biết repo sắp clone có submodule. (Vì ai đó nói với bạn như vậy.) Bạn có thể clone với cờ nói rằng bạn muốn lấy tất cả repo submodule nữa. Bạn làm điều này với switch `--recurse-submodules`:

``` {.default}
$ git clone --recurse-submodules \
        git@github.com:beejjorgensen/git-example-submodule-repo.git
```

(Lệnh trên được chia thành hai dòng để vừa lề trang.)

Và điều đó sẽ clone repo được nêu, và nó cũng sẽ clone tất cả repo được liệt kê là submodule của repo đó. Hãy thử chạy---đó là repo thực bạn có thể clone.

Sau khi chạy và vào thư mục repo, bạn sẽ thấy thư mục `git-example-repo` trong đó. Đó là một repo hoàn toàn riêng biệt bên trong repo này dưới dạng submodule. Bạn có thể `cd` vào đó và xem các file!

> **Bất kỳ lệnh Git nào bạn chạy trong cây thư mục submodule chỉ áp dụng cho submodule!** Hãy đặc biệt cẩn thận khi tạo commit trong cây thư mục submodule---`HEAD` thường bị detach (tách rời) với submodule. Thêm về điều đó sau.

Nhưng giả sử bạn quên chỉ định `--recurse-submodules`, hoặc đơn giản là không nhận ra có submodule ở đây. Đừng lo! Bạn có thể lấy chúng sau. Lệnh trên tương đương với hai (hoặc ba) lệnh sau:

``` {.default}
$ git clone \
        git@github.com:beejjorgensen/git-example-submodule-repo.git
$ cd git-example-submodule-repo
$ git submodule update --recursive --init
```

Điều đó cũng sẽ clone submodule. (`--recursive` là trong trường hợp submodule có submodule (!!) và `--init` thực hiện một số công việc bookkeeping (quản lý) cần thiết trong repo cục bộ của bạn. Nghe có vẻ qua loa nhỉ?)

Và hiện tại, có thể chỉ vậy là đủ để bạn bắt đầu làm việc! Thứ bạn thực sự cần để build dự án hiện tại là repo và submodule của nó, và bạn có thể không phụ trách submodule mà chỉ cần chúng tồn tại cho build. Vậy bây giờ bạn có thể bắt tay vào làm việc.

Nhưng trong trường hợp bạn cần làm nhiều hơn, hãy đọc tiếp!

## Tạo một Submodule

[i[Submodules-->Creating]<]

Giả sử bạn đã có một repo, nhưng bạn đã quyết định muốn đưa một repo khác vào làm submodule.

Một trường hợp dùng có thể là khi dự án repo chính của bạn phụ thuộc vào dự án khác để build, ví dụ như một thư viện. Và bạn không muốn dùng dạng nhị phân của thư viện (hoặc có thể nó không tồn tại), vì vậy bạn cần build nó.

Nếu không dùng submodule, bất kỳ ai muốn build repo của bạn cũng cần clone repo thư viện và xử lý tất cả những thứ đó. Chẳng phải sẽ tốt hơn nếu họ chỉ cần thêm cờ `--recurse-submodules` vào lệnh `clone` và mọi thứ đã được thiết lập sẵn để build?

Vậy hãy đi qua các bước thêm submodule vào repo hiện có và xem mọi thứ hoạt động như thế nào.

Hãy thoải mái dùng repo mẫu của tôi làm submodule, hoặc dùng một trong các repo của bạn, hoặc của bất kỳ ai. Không ai biết khi bạn làm submodule từ repo của họ.

Trước tiên, hãy tạo một repo mới để thử nghiệm và tạo một commit trong đó cho vui:

``` {.default}
$ git init test_repo
  Initialized empty Git repository in /frotz/test_repo/.git/
$ cd test_repo
$ echo Hello, world > foo.txt
$ git add foo.txt
$ git commit -m added
```

Và hãy thêm một submodule!

``` {.default}
$ git submodule add \
                  git@github.com:beejjorgensen/git-example-repo.git
  Cloning into '/home/beej/tmp/test_repo/git-example-repo'...
  remote: Enumerating objects: 4, done.
  remote: Counting objects: 100% (4/4), done.
  remote: Compressing objects: 100% (3/3), done.
  remote: Total 4 (delta 0), reused 4 (delta 0), pack-reused 0
  remote: (from 0)
  Receiving objects: 100% (4/4), done.
```

Đó rồi! Ừ, gần như vậy. Hãy kiểm tra trạng thái:

``` {.default}
$ git status
  On branch main
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  new file:   .gitmodules
	  new file:   git-example-repo
```

Những thứ kia trên stage là gì? `git-example-repo` là submodule. Trông hơi lạ vì Git gọi nó là "file" trong khi nó là thư mục, nhưng đó chỉ là một phần trong cách xử lý đặc biệt mà submodule nhận được.

Và còn có một file khác gọi là `.gitmodules` chứa thông tin về tất cả submodule bạn đã thêm.

Cả hai file này (coi `git-example-repo` như một file) nên được commit vào repo của bạn để những người clone nó có được thông tin submodule.

``` {.default}
$ git commit -m "added submodule"
  [main cedea64] added submodule
   2 files changed, 4 insertions(+)
   create mode 100644 .gitmodules
   create mode 160000 git-example-repo
```

Giờ bạn đã xong! Bất kỳ ai clone repo đều nhận được thông tin submodule đó.

Bạn thậm chí có thể làm với test repo của mình. Chuyển đến thư mục cha của test repo và clone nó:

``` {.default}
$ git clone --recurse-submodules test_repo test_repo2
```

Sau đó bạn có thể `cd` vào `test_repo2` và thấy submodule ở đó.

> **Tôi Có Thể Tạo Repo Cục Bộ Làm Submodule Không?** Không! Git cấm điều đó vì có một số rủi ro bảo mật mà thành thật mà nói tôi chưa thực sự đọc về. Có cách để ghi đè điều đó với một cài đặt config, điều mà tôi nghĩ sẽ khá hữu ích để mày mò và xem submodule hoạt động như thế nào, nhưng cài đặt config đó dường như không hoạt động kể từ cuối năm 2024. Vì vậy bạn phải dùng repo remote qua mạng cho submodule.

[i[Submodules-->Creating]>]

## Đặt Commit Cho Submodule {#set-submodule-commit}

[i[Submodules-->Setting the commit]<]

Phần này thực sự có nghĩa là gì?

Đây là vấn đề: repo chứa tham chiếu đến một commit cụ thể bên trong submodule. Tức là, submodule luôn được checkout tại một commit cụ thể như được định nghĩa trong repo chứa. (`HEAD` của submodule có thể được gắn vào một nhánh, nhưng cũng có thể không.)

Điều quan trọng ở đây là khi chúng ta tạo một repo với submodule, chúng ta được quyết định commit chính xác nào của submodule repo của chúng ta đang dùng. Và sau đó, quan trọng là khi ai đó clone repo của chúng ta, họ sẽ nhìn thấy submodule tại đúng commit mà chúng ta đang dùng.

Điều này cho phép chúng ta chọn một phiên bản rất cụ thể của một thư viện làm submodule, và rồi tất cả những người clone repo của chúng ta sẽ nhận được phiên bản giống nhau _bất kể repo submodule có được thay đổi ở nơi khác hay không_. Người khác có thể di chuyển `main` đến bất cứ đâu họ muốn, nhưng chúng ta vẫn dùng commit mà chúng ta đang ghim vào, ngay cả khi chúng ta fetch commit `main` mới vào submodule.

Chúng ta hiệu quả là ghim submodule vào một commit cụ thể. Và chúng ta có thể muốn làm điều đó để người khác đang phát triển submodule không đưa ra thay đổi nào phá vỡ build của repo chứa.

Làm thế nào? Khá đơn giản:

1. Vào thư mục submodule.
2. Chuyển đến commit bạn muốn dùng. Bạn có thể tham chiếu commit này bằng tên nhánh, commit hash, tag, hoặc bất kỳ thứ gì mà `git switch` chấp nhận. Dùng `--detach` nếu bạn đang tách `HEAD`.
3. Trở về thư mục repo chứa.
4. Thêm thư mục submodule.
5. Commit.

Nếu bạn muốn mày mò với repo test của tôi trên GitHub, hãy chắc chắn fork chúng trước để bạn có quyền ghi.

Hãy thực hiện điều tương tự chúng ta đã làm trong phần trước và tạo repo `test_repo`.

Và sau đó clone vào `test_repo2` để chúng ta có hai để mày mò. (Đừng quên cờ `--recurse-submodules`!)

> **Chúng ta đang clone một repo không phải bare, điều này khá lạ.** Không sao khi clone nó---cảnh sát Git sẽ không xuất hiện. Bạn chỉ không thể push lên đó. Và điều đó hoàn toàn đủ tốt cho demo này. Nhưng đây là điều bạn thường không làm.

> **Cũng hãy chú ý `HEAD` bị detach trong repo submodule được clone!** Nếu bạn nhìn vào `test_repo2/git-example-repo` và chạy `git log`, bạn sẽ thấy điều này trên dòng đầu tiên:
>
> ``` {.default}
> (HEAD, origin/main, origin/HEAD, main)
> ```
> <!-- ` -->
>
> Thấy `HEAD` bị tách khỏi `main` không?
>
> Thành thật mà nói tôi không biết chính xác các quy tắc khi `HEAD` trong submodule bị detach, nhưng không phải hiếm gặp. Thực ra, bạn nên mặc định giả sử nó bị detach và gắn nó vào một nhánh nếu cần. Thêm về điều này sau.

Bây giờ trong `test_repo`, hãy vào thư mục submodule và checkout phiên bản cũ hơn của repo submodule. Trong trường hợp này, chúng ta chỉ checkout commit trước đó từ `main`.

``` {.default}
$ cd test_repo/git-example-repo
$ git log
  commit cd1bf77d2ef08115b18d7f15a9c172dace1b2222
                           (HEAD -> main, origin/main, origin/HEAD)
  Author: Brian "Beej Jorgensen" Hall <beej@beej.us>
  Date:   Fri Dec 6 15:07:43 2024 -0800

      very important clarification

  commit d8481e125e6ef49e2fa8041b16b9dd3b8136b550
  Author: Brian "Beej Jorgensen" Hall <beej@beej.us>
  Date:   Fri Dec 6 15:07:13 2024 -0800

      improve functionality

  commit 433252748b7f9bf85e556a6a0196cdf38198fc43
  Author: Brian "Beej Jorgensen" Hall <beej@beej.us>
  Date:   Fri Jan 26 13:30:08 2024 -0800

      Added
```

Hãy chuyển đến commit cũ hơn.

``` {.default}
$ git switch --detach d8481e
  HEAD is now at d8481e1 improve functionality
```

Đến đây ổn rồi. Bây giờ hãy `cd` trở lại repo chứa và xem chúng ta đang đứng ở đâu.

``` {.default}
$ cd ..
$ git status
  On branch main
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working
    directory)
	  modified:   git-example-repo (new commits)

  no changes added to commit (use "git add" and/or "git commit -a")
```

Nhìn kìa! Thư mục submodule được liệt kê là đã modified. Nó nói "new commits", nhưng đó chỉ là cách nói rằng "mọi thứ đã thay đổi trong submodule so với commit mà tôi được ghim trước đó".

Vậy hãy thêm và commit nó.

``` {.default}
$ git add git-example-repo
$ git commit -m "update submodule commit"
  [main dd69bb8] update submodule commit
   1 file changed, 1 insertion(+), 1 deletion(-)
```

Và bây giờ hãy pull những thay đổi đó vào clone `test_repo2` của chúng ta---chú ý tùy chọn `--recurse-submodule` khi pull!

``` {.default}
$ cd ../test_repo2
$ git pull --recurse-submodules
  Fetching submodule git-example-repo
  Already up to date.
  Submodule path 'git-example-repo': checked out'
                         'd8481e125e6ef49e2fa8041b16b9dd3b8136b550'
```

Và bây giờ trong `test_repo2` nếu chúng ta nhảy vào submodule `git-example-repo`, chúng ta có thể kiểm tra log:

``` {.default}
$ git log
  commit d8481e125e6ef49e2fa8041b16b9dd3b8136b550 (HEAD)
  Author: Brian "Beej Jorgensen" Hall <beej@beej.us>
  Date:   Fri Dec 6 15:07:13 2024 -0800

      improve functionality

  commit 433252748b7f9bf85e556a6a0196cdf38198fc43
  Author: Brian "Beej Jorgensen" Hall <beej@beej.us>
  Date:   Fri Jan 26 13:30:08 2024 -0800

      Added
```

Và chúng ta thấy `HEAD` đang ở commit `d8481e`, đúng như chúng ta đã đặt trong `test_repo`. (Và chúng ta cũng không thấy `main`. Đó là commit con từ nơi `HEAD` đang ở, vì vậy nó không xuất hiện trong log. Chúng ta vẫn có thể switch đến nó nếu muốn, tất nhiên.)

Chúng ta đã làm gì? Chúng ta đã thay đổi commit mà submodule được ghim tại đó trong một repo, và sau đó pull thay đổi đó vào một repo khác!

[i[Submodules-->Setting the commit]>]

## Lấy Phiên Bản Mới Nhất Của Submodule

[i[Submodules-->Getting latest]<]

Giả sử người khác đã cập nhật commit mà submodule được ghim trong repo của bạn. Và bạn muốn bắt kịp.

Hai bước để thực hiện điều đó:

1. Trong repo chứa, `git pull`. Điều này sẽ lấy phiên bản mới nhất của repo chứa có các số commit được ghim mới cho submodule.

2. Trong repo chứa (lại), chạy:

   ``` {.default}
   git submodule update --init --recursive
   ```

   Điều này sẽ fetch dữ liệu submodule và thiết lập cho bạn trỏ đến commit đúng. 

[i[Submodules-->Getting latest]>]

## Cập Nhật Bản Thân Repo Submodule

[i[Submodules-->Updating]<]

Ý tôi là gì? Giả sử submodule chứa một thư viện nào đó, và bạn cần sửa bug trong thư viện. Và bạn cần những người dùng repo này làm submodule (hoặc theo cách khác) nhận được các thay đổi.

Vậy làm thế nào để thực hiện điều này?

Hoặc làm từ một repo độc lập, hoặc bạn cũng có thể làm _tại chỗ_ trong thư mục submodule.

### Sửa Đổi Repo Submodule Ở Nơi Khác

Cách dễ nhất cho bộ não nhỏ bé của tôi là clone submodule độc lập với bất kỳ repo nào khác. Tức là, clone nó như thể nó không phải submodule gì cả.

Sau đó bạn có thể push, pull, sửa đổi, v.v. thoải mái.

[i[Fetch]] Và sau đó khi đã sửa xong, bạn có thể vào thư mục submodule và thực hiện `git fetch` để kéo về các commit mới.

Lúc đó, có thể tiện khi chạy lệnh này:

``` {.default}
$ git log HEAD^..origin/main
```

Lệnh này sẽ hiển thị tất cả commit giữa `HEAD` và `origin/main`, bao gồm cả hai đầu, để bạn có thể thấy những gì đã được làm. (Giả sử chúng có liên quan với nhau. Nếu chúng trên các nhánh phân kỳ bạn sẽ phải sáng tạo hơn.)

Sau đó bạn chọn commit muốn ghim `HEAD` vào, switch đến đó, và chạy `add`/`commit` từ repo chứa, như đã phác thảo trong [Đặt Commit Cho Submodule](#set-submodule-commit), ở trên.

### Sửa Đổi Repo Submodule Trong Thư Mục Submodule

Nhưng khoan! Nếu submodule là một repo đầy đủ tính năng, bạn không thể chỉnh sửa ngay trong thư mục submodule sao?

Đúng! Hoàn toàn có thể.

Phần lạ duy nhất là bạn có thể có `HEAD` bị detach trong submodule, vì vậy hãy chắc chắn checkout một nhánh bạn có thể push nếu bạn muốn đi theo hướng này.

Ví dụ:

``` {.default}
$ git switch main
```

Rồi thực hiện thay đổi và push chúng (từ thư mục submodule).

Lúc này, repo chứa vẫn đang ghim vào commit cũ. Vậy bạn sẽ muốn chạy `add`/`commit` từ repo chứa, như đã phác thảo trong [Đặt Commit Cho Submodule](#set-submodule-commit), ở trên.

[i[Submodules-->Updating]>]

## Lấy Trạng Thái Submodule

[i[Submodules-->Status]<]

Về việc submodule đang được ghim vào commit nào, có một số lệnh khá hữu ích.

Đầu tiên là `git submodule status`. Lệnh này sẽ cho bạn biết `HEAD` của submodule hiện đang ở đâu.

Ví dụ, chạy từ repo chứa:

``` {.default}
$ git submodule status
898650e74c18cf4b30bdd07297d638de4a6fc7dd mysubmod (heads/main)
```

Lệnh này cho tôi biết rằng `HEAD` trong thư mục `mysubmod` đang ở commit `89865`.

Nhưng nếu bạn thấy điều này với dấu `+` ở phía trước:

``` {.default}
$ git submodule status
+1c10d608190194b7f9fbb9a442abd5c63c74cdfa mysubmod (heads/main)
```

Dấu `+` đó có nghĩa là, mặc dù `HEAD` trong submodule đang ở commit `1c10d`, repo chứa đang ghim submodule vào một commit khác! Bạn có thể thấy điều này xảy ra sau khi bạn pull một submodule (di chuyển `HEAD`) nhưng chưa cập nhật repo chứa để khớp.

Nếu bạn thấy dấu `+`, `git status` cũng sẽ cho bạn biết thêm:

``` {.default}
$ git status
  On branch main
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working
    directory)
	  modified:   mysubmod (new commits)

  no changes added to commit (use "git add" and/or "git commit -a")
```

Đúng vậy---chúng ta đã thay đổi `HEAD` trong submodule nên thư mục của nó hiển thị là `modified`.

Bạn có thể xóa dấu cộng bằng cách ghim repo vào một commit mới như đã phác thảo trong [Đặt Commit Cho Submodule](#set-submodule-commit), ở trên, hoặc bằng cách di chuyển `HEAD` submodule trở về nơi module chứa mong đợi.

> **Cũng có thể có dấu `-` phía trước commit hash.** Điều này có nghĩa là submodule chưa được khởi tạo hoặc tải về. Thử chạy `git submodule update --recursive --init`.

Làm thế nào để biết module chứa mong đợi `HEAD` submodule ở đâu? Với lệnh tiện dụng này:

``` {.default}
$ git ls-tree HEAD mysubmod
  160000 commit 898650e74c18cf4b30bdd07297d638de4a6fc7dd   mysubmod
```

[i[Submodules-->Status]>]

## Một Số Điều Bên Trong

Thực ra không hẳn là bên trong, nhưng tôi muốn chỉ ra các bước lịch sử để khởi tạo submodule mà chúng ta đã rút gọn bằng cách dùng một số switch dòng lệnh.

Ví dụ, khi chúng ta clone repo với submodule ban đầu, chúng ta đã dùng lệnh này:

``` {.default}
$ git clone --recurse-submodules \
        git@github.com:beejjorgensen/git-example-submodule-repo.git
```

Cờ `--recurse-submodules` đó đã làm rất nhiều việc cho chúng ta, clone submodule và thiết lập mọi thứ để sẵn sàng dùng.

Chúng ta cũng lưu ý rằng nếu quên switch đó, chúng ta vẫn có thể làm được:

``` {.default}
$ git clone \
        git@github.com:beejjorgensen/git-example-submodule-repo.git
$ cd git-example-submodule-repo
$ git submodule update --recursive --init
```

Vậy `--recurse-submodules` đã làm công việc đó cho chúng ta.

Nhưng hố thỏ còn sâu hơn! Cái `--init` đó cũng làm rất nhiều cho chúng ta. Hãy chia nhỏ thành quy trình thủ công đầy đủ. Đừng lo---chỉ vài bước:

``` {.default}
$ git clone \
        git@github.com:beejjorgensen/git-example-submodule-repo.git
$ cd git-example-submodule-repo
$ git submodule init
$ git submodule update --recursive
```

Vậy switch `--recurse-submodules` cho `git clone` thực ra đã chạy một loạt lệnh cho chúng ta bên dưới màn hình.

Phân tích nhỏ:

Khi bạn lần đầu clone repo chứa, có một file `.gitmodules` trong đó chỉ ra tên thư mục và URL của remote submodule. Nhưng vậy chưa đủ. Bạn phải thực hiện `git submodule init` để Git phân tích file đó và thiết lập một số bookkeeping nội bộ.

Sau đó, bạn có thể chạy `git submodule update` để kéo về dữ liệu submodule để dùng.

## Xóa một Submodule

[i[Submodules-->Deleting]<]

Cách này hơi rườm rà, nhưng không quá tệ nếu bạn làm theo từng bước.

Tất cả hành động này diễn ra từ repo chứa. Giả sử trong ví dụ này chúng ta muốn xóa module `mysubmod`---hãy thay thế tên module của bạn trong các lệnh sau.

1. Hủy khởi tạo submodule. Nếu `HEAD` của submodule không ở nơi module chứa mong đợi, bạn có thể thêm `-f` để ép buộc.

   ``` {.default}
   $ git submodule deinit mysubmod
   ```
   
   Đây là phần đảo ngược `git submodule init`.

2. Xóa thông tin bookkeeping khỏi Git internals của repo chứa.

   ``` {.default}
   $ rm -rf .git/modules/mysubmod
   ```

   Đây là phần còn lại của việc đảo ngược `git submodule init`.

3. Sửa `.gitmodules` bằng cách xóa phần về submodule. Bạn có thể làm thủ công trong editor, hoặc bạn có thể nhờ Git làm:

   ``` {.default}
   $ git config -f .gitmodules --remove-section submodule.mysubmod
   ```

   Đây là đảo ngược `git submodule add`.

4. Thêm file `.gitmodules` vào stage.

   ``` {.default}
   $ git add .gitmodules
   ```

5. Xóa cây submodule khỏi Git. Điều này cũng sẽ thêm việc xóa vào stage.

   ``` {.default}
   git rm --cached mysubmod
   ```

   Đây là kiểu như đảo ngược `git submodule update`.

6. Thực hiện `git status` để đảm bảo chúng ta đã sẵn sàng.

   ``` {.default}
   $ git status
     On branch main
     Changes to be committed:
       (use "git restore --staged <file>..." to unstage)
	         modified:   .gitmodules
	         deleted:    mysubmod
   ```

   Trông ổn.

7. Commit và push (nếu thích hợp).

   ``` {.default}
   $ git commit -m "remove mysubmod submodule"
   $ git push
   ```

Và thế là kết thúc submodule.

[i[Submodules-->Deleting]>]

[i[Submodules]>]
