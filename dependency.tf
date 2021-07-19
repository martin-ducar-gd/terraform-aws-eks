resource "null_resource" "aws_vpc_cni_delete" {   # this is custom added, remove it when module supports
  depends_on = [
    aws_eks_cluster.this
  ]
  provisioner "local-exec" {
    command = "kubectl delete daemonset --ignore-not-found=true -n kube-system --kubeconfig=${concat(local_file.kubeconfig.*.filename, [""])[0]} aws-node "
  }
}

resource "time_sleep" "wait_90_seconds" {
  depends_on = [aws_eks_cluster.this]
  create_duration = "90s"
}

