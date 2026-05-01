Technical Briefing: Terraform Variables in AWS Infrastructure

Executive Summary

This briefing document outlines the fundamental concepts, types, and management strategies for variables within AWS Terraform configurations. Variables are essential for creating reusable, consistent, and maintainable infrastructure-as-code by eliminating hard-coded values and reducing human error. The core takeaway is the categorization of variables into three functional types—Input, Output, and Locals—and the understanding of the strict precedence hierarchy that governs how Terraform resolves variable values during execution.


--------------------------------------------------------------------------------


The Strategic Importance of Variables

In a professional Terraform environment, managing hundreds or thousands of resources requires a method to handle repetitive values efficiently. Variables solve several critical issues:

* Consistency: They ensure the same value (e.g., an environment tag like "dev") is applied uniformly across different resources like S3 buckets, VPCs, and EC2 instances.
* Efficiency: Instead of manually updating every instance of a value, a single change in a variable definition updates the entire configuration.
* Error Reduction: Hard-coding values multiple times increases the risk of typos or inconsistent configurations (e.g., accidentally labeling one resource "staging" while others are "dev").
* Dynamic Configuration: Variables allow the same Terraform scripts to be used across multiple environments (Dev, Stage, Prod) by simply passing different input values.


--------------------------------------------------------------------------------


Input Variables

Input variables serve as parameters for Terraform modules. They allow users to provide values that customize the infrastructure deployment without altering the source code.

Syntax and Implementation

A basic input variable is defined using a variable block. While several fields are optional, a typical definition includes:

* Name: The local identifier for the variable (e.g., environment).
* Default: The value used if no other value is provided.
* Type: A constraint that defines what kind of data the variable holds (e.g., string).

Example Syntax:

variable "environment" {
  default = "dev"
  type    = string
}


Accessing Input Variables

Input variables are accessed within the configuration using the prefix var.. For instance, a variable named region is referenced as var.region. When a variable needs to be combined with other strings (string interpolation), the syntax ${var.variable_name} is used within double quotes.


--------------------------------------------------------------------------------


Variable Type Constraints

Terraform categorizes variable types based on the structure of the data they contain.

Category	Type	Description
Primitive	string	A sequence of characters (e.g., "hello").
	number	Numeric values.
	bool	Boolean values (true or false).
Complex	list, set, map, object, tuple	Structured data collections.
Special	null	Represents an absence of value.
	any	A placeholder that allows Terraform to auto-select the type based on the provided value.


--------------------------------------------------------------------------------


Local Variables (Locals)

Local variables are used to assign a name to an expression, allowing that expression to be reused multiple times within a module without repeating it.

* Internal Scope: Unlike input variables, locals are not set by the user via the command line or environment variables; they are strictly internal to the configuration.
* Use Case: String Concatenation: Locals are highly effective for building complex names. For example, a local variable can combine a channel name, a resource type, and an environment variable to create a unique, standardized S3 bucket name.
* Syntax: Defined in a locals block and accessed using the prefix local..


--------------------------------------------------------------------------------


Output Variables

Output variables act as return values for a Terraform configuration.

* Purpose: They are used to highlight specific information to the user after a terraform apply (e.g., a VPC ID or an EC2 Instance ID) or to pass data to other Terraform modules.
* Visibility: Output values are only fully populated once the resources have been created.
* Retrieval: Users can view output values at any time by running the command terraform output.


--------------------------------------------------------------------------------


Variable Precedence

When the same variable is assigned values through multiple sources, Terraform follows a specific hierarchy of precedence to determine which value to use. The list below moves from lowest to highest precedence:

1. Default Values: Set within the variable block.
2. Environment Variables: Shell variables prefixed with TF_VAR_ (e.g., export TF_VAR_environment=stage).
3. Variable Files: Values stored in terraform.tfvars or *.auto.tfvars files. These are loaded automatically.
4. Command Line Flags: Values passed directly during execution using the -var or -var-file options (e.g., terraform plan -var="environment=prod").

Key Insight: Command-line arguments always override any values found in .tfvars files, environment variables, or default block settings.


--------------------------------------------------------------------------------


Operational Commands Summary

Effective management of variables involves several key Terraform CLI commands:

* terraform plan: Reviews the execution plan; will show how variable changes (like switching from "dev" to "prod") will impact resources.
* terraform apply: Executes the plan. Often used with -auto-approve in testing environments.
* terraform output: Displays the values of defined output variables from the state file.
* terraform destroy: Removes all infrastructure managed by the configuration. It is a best practice to run this at the end of a demo or testing cycle to avoid unnecessary costs.
