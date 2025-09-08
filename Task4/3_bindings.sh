#!/usr/bin/env bash
# Привязки ролей к группам в соответствии с орг-структурой (по namespaces)

# finance
kubectl -n finance delete rolebinding finance-viewers-rb >/dev/null 2>&1 || true
kubectl -n finance create rolebinding finance-viewers-rb   --clusterrole=viewer   --group=finance-viewers

kubectl -n finance delete rolebinding finance-configurators-rb >/dev/null 2>&1 || true
kubectl -n finance create rolebinding finance-configurators-rb   --clusterrole=configurator   --group=finance-configurators

# marketing
kubectl -n marketing delete rolebinding marketing-viewers-rb >/dev/null 2>&1 || true
kubectl -n marketing create rolebinding marketing-viewers-rb   --clusterrole=viewer   --group=marketing-viewers

kubectl -n marketing delete rolebinding marketing-configurators-rb >/dev/null 2>&1 || true
kubectl -n marketing create rolebinding marketing-configurators-rb   --clusterrole=configurator   --group=marketing-configurators

# rnd
kubectl -n rnd delete rolebinding rnd-viewers-rb >/dev/null 2>&1 || true
kubectl -n rnd create rolebinding rnd-viewers-rb   --clusterrole=viewer   --group=rnd-viewers

kubectl -n rnd delete rolebinding rnd-configurators-rb >/dev/null 2>&1 || true
kubectl -n rnd create rolebinding rnd-configurators-rb   --clusterrole=configurator   --group=rnd-configurators

# (опционально) платформа секретов — доступ во все namespaces
for ns in finance marketing rnd; do
  kubectl -n "$ns" delete rolebinding "secrets-privileged-${ns}-rb" >/dev/null 2>&1 || true
  kubectl -n "$ns" create rolebinding "secrets-privileged-${ns}-rb"     --clusterrole=secrets-privileged     --group=platform-secrets
done

echo "Готово. Текущие привязки:"
kubectl get rolebindings -A
