
# 프로젝트 명 : MoveLog

![Image](https://github.com/user-attachments/assets/f4b22651-c199-4b71-b927-a5015959275f)


MoveLog는 운동과 식단을 동시에 기록하고 관리할 수 있는 건강 관리 앱입니다.


<br>

### ⏱️ 개발기간
    2025.02.04. ~ 2025.02.06.
<br>
    
## 💡 프로젝트 소개

    섭취한 음식과 운동 데이터를 바탕으로 자동으로 칼로리를 계산해, 보다 효율적으로 체중과 건강을 관리할 수 있습니다.

    또한, 운동 초보자를 위해 원하는 시간에 랜덤 운동을 추천하고, 올바른 운동 방법도 제공하여 보다 재미있고 효과적인 운동이 가능합니다.

<br>

## 📌 세부 기능

- 운동 기록
    
    - 날짜별로 수행한 운동
    - 운동 시간
    - 사용자 Bmr에 의한 칼로리 계산
    - 운동 목록 CRUD

- 식단 기록
    - 식단기록 CRUD
    - 날짜별로 섭취한 식단을 기록
    - 칼로리 기록

- 칼로리 자동 계산
    
   - 섭취한 칼로리 및 소모한 칼로리를 자동 계산


-  랜덤 운동 추천 및 가이드
    
    - 사용자가 지정한 시간에 푸시 알림으로 랜덤 운동 추천
    - 운동 방법 제공
    - 백그라운드 알림 지원

<br>

## 🛠 기술 스택
| 목록 | 세부사항 |
|-----| --- |
| 📱 UI | SwiftUI, NavigationStack, List, Picker, Sheet |
| 🗄 데이터 | SwiftData, AppStorage, UserDefaults, Codable | 
| 🔔 알람 | UserNotifications, UNCalendarNotificationTrigger |
| 🔄 상태 관리 | @State, @Binding, @Query, NotificationCenter |
| 🚀 비동기 처리 | async/await, Task {}, MainActor |
| 🛑 디버깅 & 오류 핸들링 | print(), do-catch, try? |
<br>


## 📦 설치 방법
1. 저장소 클론
    
        git clone https://github.com/APP-iOS7/Project4-MoveLog.git

2. 폴더 이동
    
        cd Project4-MoveLog
<br>

## 💚 팀원 소개
### 강보현 [@Bhynnnn](https://github.com/Bhynnnn)
- 프로젝트 진행 주도
- UI 구현
- 운동과 식단 기록 기능 구현 , 홈 화면 구현
- 프로필 기록 기능 구현
### 노성경 [@SeongGyeongNo](https://github.com/837100)

- 식단 추가 기능 구현
- 운동 추가 기능 구현
- 노션 작성

### 변영찬 [@ycbyun](https://github.com/ycbyun)

- 랜덤 운동 알림 설정 화면 구현
- 랜덤 운동 추천 기능 구현
- 랜덤 운동 푸시 알림 구현

<br>

## 👀 회고
### 📚 배운 점

    - SwiftUI의 상태 관리 (State, Binding, AppStorage 등) 를 더 깊이 이해할 수 있었습니다.

    - UserNotifications을 활용한 로컬 알람 시스템을 구축하는 경험을 쌓았습니다.

    - 팀원들과의 협업 과정에서 Git 브랜치 전략을 사용하고, 효율적인 코드 리뷰 방법을 배울 수 있었습니다.

### 👍 잘한 점

    - 아이디어 회의를 빠르게 끝내 다른 작업에 시간을 더 쓸 수 있었습니다.

    - 수업시간에 배운 SwiftUI를 잘 활용 할 수 있었습니다.

    - 계획했던 내용들을 모두 구현하였습니다.

### 😅 아쉬운 점 & 개선 방향

    - 디자인이 많이 부족합니다....

    - api를 사용해보고싶었으나 추가 기능을 구현하기에는 시간이 빠듯했습니다.

    - 깃의 브랜치 병합이 익숙치 않아서 협업에 차질이 생겼던 것 같습니다.
