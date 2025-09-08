## Как запускать (у меня MacOS, bash)

0. Запустить Minikube: `minikube start --driver=docker`
1. Создать namespaces: `./1_namespaces.sh`
kubectl get ns
namespace/finance created
namespace/marketing created
namespace/rnd created
NAME              STATUS   AGE
default           Active   7m49s
finance           Active   0s
ingress-nginx     Active   7m46s
kube-node-lease   Active   7m49s
kube-public       Active   7m49s
kube-system       Active   7m49s
marketing         Active   0s
rnd               Active   0s
2. Применить роли (ClusterRole): `kubectl apply -f 2_clusterroles.yaml`
clusterrole.rbac.authorization.k8s.io/viewer created
clusterrole.rbac.authorization.k8s.io/configurator created
clusterrole.rbac.authorization.k8s.io/secrets-privileged created
clusterrole.rbac.authorization.k8s.io/ns-admin created
3. Привязать роли к группам в namespaces: `./3_bindings.sh`
rolebinding.rbac.authorization.k8s.io/finance-viewers-rb created
rolebinding.rbac.authorization.k8s.io/finance-configurators-rb created
rolebinding.rbac.authorization.k8s.io/marketing-viewers-rb created
rolebinding.rbac.authorization.k8s.io/marketing-configurators-rb created
rolebinding.rbac.authorization.k8s.io/rnd-viewers-rb created
rolebinding.rbac.authorization.k8s.io/rnd-configurators-rb created
rolebinding.rbac.authorization.k8s.io/secrets-privileged-finance-rb created
rolebinding.rbac.authorization.k8s.io/secrets-privileged-marketing-rb created
rolebinding.rbac.authorization.k8s.io/secrets-privileged-rnd-rb created
Готово. Текущие привязки:
NAMESPACE       NAME                                                ROLE                                                  AGE
finance         finance-configurators-rb                            ClusterRole/configurator                              1s
finance         finance-viewers-rb                                  ClusterRole/viewer                                    1s
finance         secrets-privileged-finance-rb                       ClusterRole/secrets-privileged                        0s
ingress-nginx   ingress-nginx                                       Role/ingress-nginx                                    11m
ingress-nginx   ingress-nginx-admission                             Role/ingress-nginx-admission                          11m
kube-public     kubeadm:bootstrap-signer-clusterinfo                Role/kubeadm:bootstrap-signer-clusterinfo             11m
kube-public     system:controller:bootstrap-signer                  Role/system:controller:bootstrap-signer               11m
kube-system     kube-proxy                                          Role/kube-proxy                                       11m
kube-system     kubeadm:kubelet-config                              Role/kubeadm:kubelet-config                           11m
kube-system     kubeadm:nodes-kubeadm-config                        Role/kubeadm:nodes-kubeadm-config                     11m
kube-system     system::extension-apiserver-authentication-reader   Role/extension-apiserver-authentication-reader        11m
kube-system     system::leader-locking-kube-controller-manager      Role/system::leader-locking-kube-controller-manager   11m
kube-system     system::leader-locking-kube-scheduler               Role/system::leader-locking-kube-scheduler            11m
kube-system     system:controller:bootstrap-signer                  Role/system:controller:bootstrap-signer               11m
kube-system     system:controller:cloud-provider                    Role/system:controller:cloud-provider                 11m
kube-system     system:controller:token-cleaner                     Role/system:controller:token-cleaner                  11m
kube-system     system:persistent-volume-provisioner                Role/system:persistent-volume-provisioner             11m
marketing       marketing-configurators-rb                          ClusterRole/configurator                              1s
marketing       marketing-viewers-rb                                ClusterRole/viewer                                    1s
marketing       secrets-privileged-marketing-rb                     ClusterRole/secrets-privileged                        0s
rnd             rnd-configurators-rb                                ClusterRole/configurator                              0s
rnd             rnd-viewers-rb                                      ClusterRole/viewer                                    1s
rnd             secrets-privileged-rnd-rb                           ClusterRole/secrets-privileged                        0s
4. Создать пользователей и выдать сертификаты через CSR API: 
`./4_create-user.sh alice finance-viewers` 
Generating RSA private key, 2048 bit long modulus
.................................................................+++++
...............................+++++
e is 65537 (0x10001)
certificatesigningrequest.certificates.k8s.io/alice-csr created
certificatesigningrequest.certificates.k8s.io/alice-csr approved
Сертификат пользователя сохранён в ./certs/alice/alice.crt
`./4_create-user.sh bob rnd-configurators`
Generating RSA private key, 2048 bit long modulus
.............................................................................................................+++++
....................................................................+++++
e is 65537 (0x10001)
certificatesigningrequest.certificates.k8s.io/bob-csr created
certificatesigningrequest.certificates.k8s.io/bob-csr approved
Сертификат пользователя сохранён в ./certs/bob/bob.crt
5. Создать kubeconfig для пользователей: 
`./5_kubeconfig.sh alice`
Cluster "minikube" set.
User "alice" set.
Context "alice@minikube" created.
Switched to context "alice@minikube".
Kubeconfig для пользователя сохранён: ./certs/alice/alice-kubeconfig

`./5_kubeconfig.sh bob`
Cluster "minikube" set.
User "bob" set.
Context "bob@minikube" created.
Switched to context "bob@minikube".
Kubeconfig для пользователя сохранён: ./certs/bob/bob-kubeconfig


