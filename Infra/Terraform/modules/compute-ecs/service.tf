resource "aws_ecs_service" "this" {
  name            = "${var.name}-service"
  cluster         = var.ecs_cluster_id
  launch_type     = "FARGATE"
  desired_count   = var.desired_count
  task_definition = aws_ecs_task_definition.this.arn

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.name
    container_port   = var.container_port
  }

  depends_on = [
    aws_lb_listener.this,
    aws_lb_target_group.this
  ]
}
