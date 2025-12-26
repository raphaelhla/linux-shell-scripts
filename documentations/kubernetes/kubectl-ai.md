# KubectlAI - Documentation & Evaluation

## 1. Introduction

[KubectlAI](https://github.com/GoogleCloudPlatform/kubectl-ai) is an open-source plugin that extends the Kubernetes `kubectl` command-line interface with natural language capabilities powered by Large Language Models (LLMs). It allows operators, developers, and compliance engineers to interact with Kubernetes clusters using plain English (or other supported languages), simplifying cluster management, diagnostics, and compliance queries.

Instead of remembering complex `kubectl` commands, users can simply type:

> *"Show me all pods that are not running."*

KubectlAI then translates this into the correct `kubectl` command and executes it, returning the result.

KubectlAI supports multiple LLM backends, including:

* OpenAI (GPT-3.5 / GPT-4)
* Google Gemini
* Azure OpenAI
* Local LLMs via OpenAI-compatible APIs


## 2. Installation

### 2.1. Prerequisites

Before installation, you need to have:

- `kubectl` installed and configured.
- API key from your preferred LLM provider (e.g., OpenAI).

### 2.2. Install
To install, run the following command:

```bash
curl -sSL https://raw.githubusercontent.com/GoogleCloudPlatform/kubectl-ai/main/install.sh | bash
```

### 2.3. Verify installation

```bash
kubectl-ai version
```

## 3. Configuration

Before using KubectlAI, you need to set up your LLM credentials.

### 3.1. Gemini configuration

Configure the api key:

```bash
export GEMINI_API_KEY=your_api_key_here
```

Configure the `model` and `llm-provider` using a YAML configuration file:

```bash
mkdir -p ~/.config/kubectl-ai/
cat <<EOF > ~/.config/kubectl-ai/config.yaml
model: gemini-2.5-flash-preview-04-17
llm-provider: gemini
EOF
```

### 3.2. Verify your configuration:

```bash
kubectl-ai --quiet model
```

## 4. Basic Usage

KubectlAI offers two main ways to interact with your Kubernetes cluster using natural language:

### 4.1. Single-Command Mode

You can run a single natural language query directly by passing it as an argument:

```bash
kubectl-ai "List all pods that are not running."
```

**Example output:**

```bash
ubuntu@control-plane:~$ kubectl-ai "List all pods that are not running."

Running: kubectl get pods --field-selector status.phase!=Running

There are no pods that are not running in the default namespace.
```

### 4.2. Interactive Chat Mode

You can also start an interactive chat session, where you can ask multiple questions one after another:

```bash
kubectl-ai
```

**Example session:**

```bash
ubuntu@control-plane:~$ kubectl-ai

Hey there, what can I help you with today?

>>> List all pods that are not running.

Running: kubectl get pods --field-selector status.phase!=Running

All pods are running in the default namespace. There are no pods found that are not in the running state.

>>>
```

## 5. Examples Usage

Below are some examples of natural language queries you can use with `kubectl-ai`.

```bash
kubectl-ai "Show me all deployments in all namespaces"
```

```bash
kubectl-ai "Restart deployment spire-server in spire nampespace"
```

```bash
kubectl-ai "Show me the yaml file of the deployment spire-server in namespace spire"
```

```bash
kubectl-ai "Delete all pods in default namespace"
```

```bash
kubectl-ai "List all container images used in the cluster."
```

```bash
kubectl-ai "There are pods in CrashLoopBackOff. What can I do?"
```


## 6. Vulnerability Scanning Integration with Trivy

KubectlAI integrates with [Trivy](https://github.com/aquasecurity/trivy) to extend its natural language capabilities into security analysis.

If you have **Trivy installed in your environment**, KubectlAI can leverage it to check container images for known vulnerabilities using simple natural language queries.

Trivy must be installed locally on the same machine running KubectlAI.

### Example Usage

```bash
kubectl-ai "Scan the nginx:latest image for vulnerabilities"
```

KubectlAI will automatically invoke Trivy to analyze the requested image and return a vulnerability report.

Example translation:

```bash
trivy image nginx:latest
```

## 7. Risks & Limitations

* **Destructive commands risk:** Users may accidentally ask for deletion or scale-down operations.
* **LLM hallucination:** May occasionally suggest invalid or dangerous commands.
* **Cost implications:** Using GPT-4/GPT-4o incurs API costs.
* **Privacy concerns:** Cluster state data is sent to external LLM providers (unless self-hosted).
* **Limited context-awareness** for very large clusters.
* **Not a replacement for RBAC**: Still requires appropriate cluster permissions.

## 9. References

* 🔗 [KubectlAI GitHub Repository](https://github.com/GoogleCloudPlatform/kubectl-ai)
* 🔗 [OpenAI Pricing](https://openai.com/pricing)
* 🔗 [Google Gemini Pricing](https://cloud.google.com/vertex-ai/docs/generative-ai/pricing)
* 🔗 [Google Gemini Pricing 2](https://ai.google.dev/gemini-api/docs/pricing?hl=pt-br)
* 🔗 [Trivy](https://github.com/aquasecurity/trivy)



