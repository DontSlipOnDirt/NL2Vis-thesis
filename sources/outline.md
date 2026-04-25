**Intro & lit review:**  
Borrow a lot of topics from the NL2Vis lit review (Luong, Nguyen 2025\)

* Introduce NL2Vis topic and evolution from NL2SQL  
* Define good visualizations  
* Discuss technical and privacy challenges of current setups with just chatbots (Claude, Gemini, ChatGPT, etc.), and   
  * Discuss use case of private data for businesses and social institutions like police, SAP, etc., which is most relevant for this thesis  
  * Costs of APIs if just using big chatbots (ChatGPT, Claude, Gemini)  
  * Ambiguity of promtps  
  * Evaluation methods/metrics, visualizations can be subjective and methods to get to the same result may differ  
  * Generalization across data schemas and queries  
  * Support for human feedback  
  * Scalability/system constraints:   
    * Prompt memory  
    * Data schema memory/size  
    * Memory of LLM  
    * Inference speed  
    * If used close APIs, reproducibility also becomes more difficult  
    * Others  
  * Multi-lingual support  
* Introduce the different approaches and what they try to address from the long list of challenges  
  * Specify more about multi-agent  
* Discuss datasets and their constraints from   
  * Discuss nvbench and how viseval improves on it

**Scope:**

* Base on nvAagent, multi agent LLM system  
* VisEval benchmark  
  * Give info like number of pairs, difficulties, single vs multi-table, etc.  
  * Discuss the constraints:  
    * unambiguous prompts  
    * database ID is provided  
* The challenges and use cases I adress are:  
  * less technical users  
  * Unambiguous prompts  
  * private data  
* experimentation with smaller setups to compare performance/efficiency against bigger models  
* Add visual critic to hopefully increase performance as replacement for human feedback.  
  * Human iteration could be a big factor of improvement; however, for our use case, it is too much effort to automate that so we try iteration with LLM as judge (visual LLM iterating into composer).   
  * Datasets/benchmarks also do not so far accommodate human iteration. An idea could be to have possible additional human feedback prompts along with the initial prompt that are fed to the system when it fails.  
  * Visual critic did not work\! The evaluation itself actually points to the data integration itself being the main issue  
* Because VLM did not work, it shows that visualization coding itself usually works but the data integration is the main issue.  
* Main topic will be exploration of possible optimizations of this system which include:  
  * Improving composer itself to validate with user’s query  
  *   
  * Improving the validator to give better feedback all the way to the composer.  
  * Implement memory in UI to experiment with iterative feedback given:  
    * Human experimenting by hand would be very costly  
    * Maybe have an LLM agent simulate the human to have the multi-agent system reach a passing. Kind of similar to the visual-critic but this one would focus on seeing correct data.  
    * Maybe benchmark can be enhanced to simulate the iterative flow by having possible additional user queries depending on which check the MA system fails.   
  * Ablation of agents to see which are most important with smaller models because cited paper only does it for the proprietary models.

**Methodology:**

* Run locally with vLLM  
* Still have gpt-4o-mini as readability judge  
* Without VLLM judge, try:  
  * small LLMs up to 32B  
  * fine-tuned coder models  
  * Quantized models  
  * VL model  
* With VLLM judgevisual critic, tried:  
  * VL model, but there was no improvement because eval already failed at data\_checks and scales\_and\_ticks\_check  
* Possible exploration

**Results & Analysis:**

* Metrics:  
  * Invalid  
  * Illegal  
  * **Pass rate**  
  * Readability, actually kinda useless because only ones that are valida are passed to visual judge and the code can already always produce mediocre visualizations, ending up with a mean score of 3.5  
  * Quality,   
* Token costs vs. energy costs  
* Inference time  
* Effectiveness of different setups

* Identify which agent fails the most  
* Classify types of failures

**Discussion & limitations:**  
Limitations:

* Price of the visual judge, gpt-4o-mini. Less readability scores  
* Hardware constraints, a smaller slice of H100  
* Layout check doesn’t work on cluster because of chrome driver issues

Discussion/possible improvements:

* In commercial product, have the human-in-the-loop giving feedback into a memory of the chat  
* Possible improvements with larger parameters  
* More fine-tuned VLM for these specific prompts/data, and also that looks at data visualization images  
* 

**Appendix/Supplementary materials:**

* Experiment with ambiguous/irrelevant prompts (e.g. give me a cookie recipe)  
* Give prompts  
* Discuss how GPT 4o is used as judge for readability

**Deliverables/Nice to haves:**

* Cleaned up GitHub repo  
* Docker image of system  
* Web interface working:  
  * With vLLM  
  * With updated Streamlit/modern framework interface  
  * With chat history?  
  * Iterative conversation

*Things to possibly justify with research:*
1. Multi-agent system to improve performance
2. Distrust in larger AI companies/APIs
3. What is good visualization, especially according to a user request
4. vLLM as LLM server
5. Qwen models
6. Fine-tuned models
7. Quantization performance
8. Probability/standard deviation of getting worse/better performance from LLMs. Or confidence that LLM should  perform just as well over multiple runs.
9. Performance and inference speed without processor/enhanced schemas
