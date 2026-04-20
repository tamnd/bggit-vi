# Cộng Tác Trên Các Branch

[i[Collaboration-->Across branches]<]

Giả sử bạn đang trong một nhóm lập trình viên và tất cả mọi người đều có quyền truy cập vào cùng một repo GitHub. (Một người trong nhóm sở hữu repo, và họ đã [fl[thêm tất cả mọi người làm collaborator|https://tinyurl.com/y5kzpeyk]].)

> Tôi sẽ dùng thuật ngữ _collaborator_ (cộng tác viên) để chỉ "ai đó
> mà bạn đã cấp quyền ghi vào repo của bạn".

Làm thế nào để tất cả mọi người cấu trúc công việc để giảm thiểu xung đột?

Có một số cách để làm điều này.

* Mọi người đều là collaborator trên repo, và:
  * Mọi người dùng cùng một branch, có thể là `main`, hoặc
  * Mọi người dùng remote tracking branch riêng và định kỳ merge với branch main, hoặc
  * Mọi người dùng remote tracking branch riêng và định kỳ merge với branch development, branch này lại định kỳ được merge vào `main` cho mỗi bản phát hành chính thức.
* Hoặc mọi người có repo riêng (và không phải collaborator trên cùng một repo), và:
  * Mọi người dùng _pull request_ hay các phương thức đồng bộ hóa khác để merge repo của họ vào repo của các dev khác.

Ta sẽ xem xét vài cách đầu tiên trong chương này, nhưng sẽ để pull request cho sau.

Không có phương pháp phù hợp với tất cả mọi người cho teamwork với Git, và các phương thức được trình bày dưới đây có thể kết hợp với nhau cùng với local topic branch, hoặc người ta có nhiều remote tracking branch, hay gì đó khác. Thường thì ban quản lý sẽ có phương pháp họ muốn sử dụng cho cộng tác, có thể là một trong những cách trong phần này, hoặc biến thể, hoặc thứ hoàn toàn khác.

Dù sao, chiến lược tốt nhất cho bạn, người học, là chỉ cần làm quen với các công cụ (branching, merging, giải quyết conflict, pushing, pulling, remote tracking branch) và dùng chúng đúng chỗ nhất có thể.

Và khi mới bắt đầu, trực giác của bạn về "đúng chỗ nhất" có thể chưa hoàn hảo, nhưng nó không chết người và bạn sẽ tự rút ra kinh nghiệm thôi.

> *"Ồ tuyệt. Thêm một bài học f\-\-\-ing học từ bản thân."* \
> \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ---Câu trích dẫn thực tế từ mẹ tôi

Cuối cùng, tôi sẽ dùng GitHub trong tất cả các ví dụ này, nhưng bạn có thể dùng bất kỳ máy chủ hay dịch vụ nào làm remote thay thế.

## Giao Tiếp và Phân Công

[i[Communication]]

Git không thể cứu bạn khỏi việc giao tiếp kém. Cách duy nhất để giảm thiểu xung đột trong một dự án chung là giao tiếp với nhóm của bạn và phân công rõ ràng các nhiệm vụ khác nhau cho mọi người theo cách không xung đột.

Hai người không nên chỉnh sửa cùng một phần của cùng một file, hay thậm chí bất kỳ phần nào của cùng một file. Đó là nguyên tắc hơn là quy tắc, nhưng nếu bạn tuân theo nó, bạn sẽ không bao giờ có merge conflict.

Như ta đã thấy, không phải là tận thế nếu có merge conflict, nhưng cuộc sống chắc chắn dễ dàng hơn nếu chúng chỉ đơn giản là được tránh.

Kết luận: Không có giao tiếp tốt và phân phối công việc tốt trong nhóm, bạn sẽ thất bại. Lập kế hoạch để không ai dẫm lên chân nhau, và thực hiện theo đó.

## Cách Tiếp Cận: Mọi Người Dùng Một Branch

[i[Workflow-->One Branch]<]

Cách này thực sự đơn giản. Mọi người đều có quyền push vào repo và làm tất cả công việc trên branch `main`.

Ưu điểm:

* Cực kỳ đơn giản để thiết lập.
* Về mặt khái niệm không có nhiều thứ cần xử lý.
* Tất cả công việc lập tức có sẵn cho tất cả collaborator sau khi push.

Nhược điểm:

* Khả năng merge conflict cao hơn.
* Trừ khi bạn đang rebase (sẽ nói thêm sau), bạn sẽ có nhiều merge commit.
* Bạn không thể push code chưa hoạt động vì nó sẽ làm hỏng mọi thứ cho tất cả mọi người.

Thiết lập ban đầu:

* Một người tạo repo GitHub.
* Chủ sở hữu repo GitHub thêm tất cả thành viên nhóm làm collaborator.
* Mọi người clone repo.

Quy trình làm việc:

* Công việc được phân công cho tất cả collaborator. Công việc nên không chồng chéo nhau nhất có thể.
* Mọi người định kỳ pull `main` và giải quyết mọi merge conflict.
* Mọi người push công việc của họ lên `main`.

Trong thực tế, cách tiếp cận này có thể chỉ được dùng trên các nhóm rất nhỏ, ví dụ tối đa ba người, với giao tiếp thường xuyên và dễ dàng giữa tất cả thành viên. Nếu bạn đang làm việc trên một nhóm nhỏ ở trường, đây có thể đủ dùng, nhưng tôi vẫn khuyến nghị thử cách tiếp cận khác chỉ để có kinh nghiệm.

Các cách tiếp cận khác không phức tạp hơn nhiều, và cho bạn nhiều linh hoạt hơn.

[i[Workflow-->One Branch]>]

## Cách Tiếp Cận: Mọi Người Dùng Branch Riêng

[i[Workflow-->One Branch per Dev]<]

Trong kịch bản này, ta coi `main` là code đang hoạt động, và coi các branch của contributor là nơi thực hiện công việc. Khi một contributor hoàn thiện code, họ merge nó trở lại vào `main`.

Ưu điểm:

* Bạn có thể làm việc trên branch riêng mà không lo làm hỏng công việc của người khác.
* Bạn có thể commit code chưa hoạt động vì không ai khác có thể thấy nó. (Ví dụ bạn đang kết thúc ngày làm việc và muốn push một số code chưa hoàn chỉnh để backup.)
* Ít khả năng merge conflict hơn vì ít merge hơn so với khi mọi người commit vào `main`.

Nhược điểm:

* Nếu branch của bạn phân kỳ quá xa so với `main`, việc merge có thể trở nên đau đớn.
* Trừ khi bạn đang [rebase và squash](#squashing-commits), công việc dần dần trên branch của bạn có thể "ô nhiễm" lịch sử commit trên `main` với nhiều commit nhỏ.

Thiết lập ban đầu:

* Một người tạo repo GitHub.
* Chủ sở hữu repo GitHub thêm tất cả thành viên nhóm làm collaborator.
* Mọi người clone repo.
* Mọi người tạo branch riêng, có thể đặt tên theo tên mình.
* Mọi người push branch của họ lên GitHub, biến chúng thành remote-tracking branch. (Ta làm điều này để công việc của bạn được backup hiệu quả trên GitHub khi bạn push.)

Quy trình làm việc:

* Công việc được phân công cho tất cả collaborator. Công việc nên không chồng chéo nhau nhất có thể.
* Khi các collaborator hoàn thành nhiệm vụ, họ sẽ:
  * Test mọi thứ trên branch của họ.
  * Merge `main` mới nhất vào branch của họ; pull để chắc chắn bạn có phiên bản mới nhất. (Collaborator có thể đã có `main` mới nhất nếu không ai merge vào nó, khiến Git báo không có gì để làm. Điều này ổn.)
  * Test mọi thứ, và sửa nếu cần.
  * Merge branch đang hoạt động của họ vào `main`.
  * Push.
    * Nếu ai đó đã sửa đổi `main` trong khi bạn đang test, Git sẽ than phiền rằng bạn phải pull trước khi có thể push. Nếu có conflict tại điểm này, bạn sẽ phải giải quyết, test, và push. Và bạn sẽ phải merge `main` trở lại vào branch của mình để branch của bạn được cập nhật.

Kết quả sẽ trông như Figure_#.1 ban đầu, khi tất cả các collaborator đã tạo branch riêng từ `main`.

![Collaborators branching off `main`.](img_100_010.pdf "[Collaborators branching off main.]")

<!--
``` {.default}
             +
            /+
           / #\
          /  + \
         /  /#  \
        /  / #   \
       /  /  #M  |c
      /  /   #A  |h
     /  b|   #I  |r
    a|  o|   #N  |i
    l|  b|   #   |s
    i|   |   #   |
    c|   |   #   |
    e|   |   #   |
     |   |   #   |
     :   :   :   :
```
-->

Giả sử Chris (trên branch `chris`) đã hoàn thành công việc và muốn các contributor khác có thể thấy nó. Đã đến lúc merge vào `main`, như ta thấy trong Figure_#.2.

![Chris merges back into `main`.](img_100_020.pdf "[Chris merges back into main.]")

<!--
``` {.default}
     |  b|   #   |
    a|  o|   #   |c
    l|  b|   #   |h
    i|   |   #   |r
    c|   |   #M  |i
    e|   |   #A  |s
     |   |   #I  |
     |   |   #N  /
     |   |   #  /
     |   |   # /
     |   |   #/
     |   |   +
```
-->

Sau đó, các contributor khác khi pull `main` sẽ thấy các thay đổi.

[i[Workflow-->One Branch per Dev]>]

## Cách Tiếp Cận: Mọi Người Merge Vào Branch Dev

[i[Workflow-->Dev branch]<]

Trong kịch bản này, ta coi `main` là code đã được phát hành mà ta sẽ phân phối, thường được gắn nhãn phiên bản, và ta coi branch `dev` là code đang làm việc, chưa phát hành. Và như kịch bản trước, mọi người đều có branch riêng để phát triển.

Ý tưởng cơ bản là ta sẽ có hai phiên bản code đang hoạt động:

1. Phiên bản công khai, đã phát hành trên `main`.
2. Phiên bản nội bộ, riêng tư trên `dev`.

Và tất nhiên, ta sẽ có một branch cho mỗi collaborator.

Cách nghĩ khác về điều này là ta sẽ có bản build nội bộ trên `dev` tốt cho kiểm thử và sau đó, khi mọi thứ đã sẵn sàng, ta sẽ "chứng nhận" nó và merge vào `main`.

Vậy sẽ có nhiều lần merge vào `dev` từ tất cả các branch developer, và sau đó thỉnh thoảng sẽ có một lần merge từ `dev` vào `main`.

*Các developer sẽ không bao giờ trực tiếp merge vào `main`!* Thường đó là việc của người có vai trò quản lý.

![Working on the `dev` branch.](img_100_030.pdf "[Working on the dev branch]")

Toàn bộ quy trình hoạt động như Figure_#.3. Đây là hình ảnh bận rộn, nhưng lưu ý cách Bob và Alice chỉ merge công việc của họ vào branch `dev`, và sau đó thỉnh thoảng manager merge branch `dev` vào `main` và gắn nhãn commit đó với số phiên bản.

Ưu điểm:

* Tất cả ưu điểm của việc mọi người có branch riêng.
* Bạn có một branch nội bộ để có thể tạo bản build hoàn chỉnh cho kiểm thử nội bộ hay bên ngoài.

Nhược điểm:

* Phức tạp và quản lý hơn một chút.
* Nếu branch của bạn phân kỳ quá xa so với `dev`, việc merge có thể trở nên đau đớn.
* Nếu branch `dev` phân kỳ quá xa so với `main`, việc merge có thể trở nên đau đớn.
* Trừ khi bạn đang rebase, công việc dần dần trên branch của bạn có thể "ô nhiễm" lịch sử commit trên `dev` và `main` với nhiều commit nhỏ.

Thiết lập ban đầu:

* Một người tạo repo GitHub.
* Chủ sở hữu repo GitHub thêm tất cả thành viên nhóm làm collaborator.
* Chủ sở hữu tạo branch `dev`.
* Mọi người clone repo.
* Mọi người tạo branch riêng, có thể đặt tên theo tên mình.
* Mọi người push branch của họ lên GitHub, biến chúng thành remote-tracking branch. (Ta làm điều này để công việc của bạn được backup hiệu quả trên GitHub khi bạn push.)

Quy trình làm việc:

* Công việc được phân công cho tất cả collaborator. Công việc nên không chồng chéo nhau nhất có thể.
* Khi các collaborator hoàn thành nhiệm vụ, họ sẽ:
  * Test mọi thứ trên branch của họ.
  * Merge `dev` mới nhất vào branch của họ; pull để chắc chắn bạn có phiên bản mới nhất. (Collaborator có thể đã có `dev` mới nhất nếu không ai merge vào nó, khiến Git báo không có gì để làm. Điều này ổn.)
  * Test mọi thứ, và sửa nếu cần.
  * Merge branch đang hoạt động của họ vào `dev`.
  * Push.
    * Nếu ai đó đã sửa đổi `dev` trong khi bạn đang test, Git sẽ than phiền rằng bạn phải pull trước khi có thể push. Nếu có conflict tại điểm này, bạn sẽ phải giải quyết, test, và push. Và bạn sẽ phải merge `dev` trở lại vào branch của mình để branch của bạn được cập nhật.

Quy trình làm việc của Manager:

* Phối hợp với tất cả dev để có bản release candidate trong `dev` được test và sẵn sàng.
* Merge bản release candidate đó (một commit nào đó) từ `dev` vào `main`.
* Gắn nhãn commit `main` với số phiên bản nào đó, tùy chọn.

[i[Workflow-->Dev branch]>]
[i[Collaboration-->Across branches]>]
