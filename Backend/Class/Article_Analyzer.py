from collections import Counter
import re
from typing import Tuple, Dict

class ArticleRelevanceAnalyzer:
    def __init__(self):
        """Initialize with basic English stop words and question words."""
        self.stop_words = {
            'a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from', 
            'has', 'he', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 
            'to', 'was', 'were', 'will', 'with'
        }
        
        self.question_words = {
            'what', 'when', 'where', 'who', 'why', 'how', 'which', 'whose', 
            'whom', 'can', 'could', 'would', 'should', 'do', 'does', 'did'
        }

    def preprocess_text(self, text: str) -> list:
        """Clean and tokenize text, removing stop words."""
        # Convert to lowercase and remove punctuation
        text = text.lower()
        text = re.sub(r'[^\w\s]', '', text)
        
        # Tokenize and remove stop words
        tokens = [word for word in text.split() if word not in self.stop_words]
        return tokens

    def extract_key_terms(self, question: str) -> list:
        """Extract key terms from question, excluding question words."""
        tokens = self.preprocess_text(question)
        return [word for word in tokens if word not in self.question_words]

    def calculate_relevance(self, question: str, article_description: str) -> Tuple[float, Dict]:
        """Calculate relevance between a question and article description."""
        # Extract key terms from question
        question_terms = self.extract_key_terms(question)
        
        # Preprocess article description
        article_tokens = self.preprocess_text(article_description)

        if not question_terms or not article_tokens:
            return 0.0, {
                'topic_overlap': 0.0,
                'key_terms_coverage': 0.0,
                'context_relevance': 0.0
            }

        # Calculate topic overlap using sets
        q_set = set(question_terms)
        a_set = set(article_tokens)
        topic_overlap = len(q_set.intersection(a_set)) / len(q_set)

        # Calculate key terms coverage
        q_terms = Counter(question_terms)
        a_terms = Counter(article_tokens)
        covered_terms = sum((q_terms & a_terms).values())
        key_terms_coverage = covered_terms / len(question_terms)

        # Calculate context relevance
        # Look for related terms in a window around matched key terms
        context_matches = 0
        for i, token in enumerate(article_tokens):
            if token in question_terms:
                # Look at surrounding words (window of 3 words before and after)
                start = max(0, i - 3)
                end = min(len(article_tokens), i + 4)
                window = article_tokens[start:end]
                context_matches += len(set(window).intersection(q_set)) - 1  # -1 to not count the term itself

        max_possible_context = len(question_terms) * 6  # maximum possible matches in windows
        context_relevance = min(1.0, context_matches / max_possible_context if max_possible_context > 0 else 0)

        # Calculate final score (weighted average)
        weights = {
            'topic_overlap': 0.4,
            'key_terms_coverage': 0.4,
            'context_relevance': 0.2
        }

        final_score = (
            topic_overlap * weights['topic_overlap'] +
            key_terms_coverage * weights['key_terms_coverage'] +
            context_relevance * weights['context_relevance']
        )

        metrics = {
            'topic_overlap': round(topic_overlap, 3),
            'key_terms_coverage': round(key_terms_coverage, 3),
            'context_relevance': round(context_relevance, 3)
        }

        return round(final_score, 3), metrics

def analyze_article_relevance(question: str, article_description: str) -> float:
    """Analyze and print the relevance between a question and article description."""
    analyzer = ArticleRelevanceAnalyzer()
    score, metrics = analyzer.calculate_relevance(question, article_description)
    
    # print(f"\nArticle Relevance Analysis:")
    # print(f"Overall Score: {score}")
    # print("\nDetailed Metrics:")
    # print(f"- Topic Overlap: {metrics['topic_overlap']}")
    # print(f"- Key Terms Coverage: {metrics['key_terms_coverage']}")
    # print(f"- Context Relevance: {metrics['context_relevance']}")
    
 
    return score

# Example usage
if __name__ == "__main__":
    question = "What are the environmental impacts of plastic pollution?"
    article_description = "This study examines the effects of microplastic contamination on marine ecosystems, focusing on how plastic debris affects marine life and ocean chemistry."
    
    analyze_article_relevance(question, article_description)
