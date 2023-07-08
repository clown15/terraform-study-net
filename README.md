# Terraform study 1주차
## Terraform 이란?
Terraform은 Hashicorp에서 오픈소스로 개발중인 인프라를 코드를 통해 관리하는 도구 즉 Infrastructure as Code(IaC) 입니다.
다른 IaC도구들이 많지만 Terraform을 사용한다면 다양한 클라우드에 인프라를 배포할 수 있습니다.

## 기초 명령어
- terraform init : terraform code를 실행하기 위해 필요한 파일들(provider등)을 다운받는 명령어
- terraform plan : code를 실행했을 때 인프라에 어떤 변화가 있을지 확인하는 명령어(실제 실행X)
- terraform apply : code를 실행하는 명령어로 apply를 실행하면 plan처럼 어떤 변화가 있는지 알려주고 승인을 통해 작동한다.
- terraform destroy : code로 프로비저닝한 인프라를 삭제하는 명령어

## Terraform 실행 방식
Terraform은 각 resource들에 관계가 없다면 기본적으로 병렬로 실행한다.
실행 순서를 정의할 필요가 있을경우 depends_on을 통해 명시적 선언이 가능하며 resource block 내부에서 다른 resource참조시 terraform이 자동으로 관계가 정의되는 암시적 종속성을 갖게된다.

### 암시적 종속성
```
resource "local_file" "abc" {
  content  = "123!"
  filename = "${path.module}/abc.txt"
}

resource "local_file" "def" {
  content  = local_file.abc.content
  filename = "${path.module}/def.txt"
}
```
위 코드와 같이 resource block내부에서 다른 resource참조시 terraform이 자동으로 자동으로 관계를 정의한다.
### 명시적 종속성
```
resource "local_file" "abc" {
  content  = "123!"
  filename = "${path.module}/abc.txt"
}

resource "local_file" "def" {
  content  = "456!"
  filename = "${path.module}/def.txt"

  depends_on = [ local_file.abc ]
}
```
depends_on을 통해 명시적으로 관계를 정의할 수 있다.

## 수명주기
**lifecycle**은 리소스의 **기본 수명주기**를 작업자가 의도적으로 **변경**하는 **메타인수**다. 메타인수 내에는 아래 선언이 가능.
- create_before_destroy (bool): 리소스 수정 시 신규 리소스를 우선 생성하고 기존 리소스를 삭제
- prevent_destroy (bool): 해당 리소스를 삭제 Destroy 하려 할 때 명시적으로 거부
- ignore_changes (list): 리소스 요소에 선언된 인수의 변경 사항을 테라폼 실행 시 무시
- precondition: 리소스 요소에 선언해 인수의 조건을 검증
- postcondition: Plan과 Apply 이후의 결과를 속성 값으로 검증

테라폼의 기본 수명주기는 **삭제 후 생성**이기 때문에 작업자가 의도적으로 수정된 리소스를 먼저 생성하기를 원할 수 있다.
이 경우 **create_before_destroy** 가 **true**로 선언되면 의도한 생성을 실행한 후 삭제로 동작한다.
이런식으로 lifecycle수정시 사용자가 의도한대로 작동하지 않거나 예기치 못한 오류가 발생할 수 있기 때문에 주의해야 한다.

### postcondition & postcondition
resource의 속성값을 강제할 수 있다. 아래 예시 코드는 file_name이 list에 없는 이름일 경우 오류를 바환하면서 실행되지 않습니다.
```hcl
variable "file_name" {
  default = "step11.txt"
}

resource "local_file" "abc" {
  content  = "lifecycle - step 6"
  filename = "${path.module}/${var.file_name}"

  lifecycle {
    postcondition {
      condition     = contains(["step0.txt", "step1.txt", "step2.txt", "step3.txt", "step4.txt", "step5.txt", "step6.txt", "step7.txt"], "${var.file_name}")
      error_message = "file name is not \"step6.txt\""
    }
  }
}
```