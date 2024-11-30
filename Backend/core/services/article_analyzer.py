"""
Module for analyzing the relevance of articles to specific questions.
"""

from collections import Counter
import re
from typing import Tuple, Dict


class ArticleRelevanceAnalyzer:
    """Class to analyze the relevance of articles to questions."""

    def __init__(self):
        """Initialize with basic English stop words and question words."""
        self.stop_words = {
            "a",
            "an",
            "and",
            "are",
            "as",
            "at",
            "be",
            "by",
            "for",
            "from",
            "has",
            "he",
            "in",
            "is",
            "it",
            "its",
            "of",
            "on",
            "that",
            "the",
            "to",
            "was",
            "were",
            "will",
            "with",
        }

        self.question_words = {
            "what",
            "when",
            "where",
            "who",
            "why",
            "how",
            "which",
            "whose",
            "whom",
            "can",
            "could",
            "would",
            "should",
            "do",
            "does",
            "did",
        }

    def preprocess_text(self, text: str) -> list:
        """Clean and tokenize text, removing stop words."""
        text = text.lower()
        text = re.sub(r"[^\w\s]", "", text)
        tokens = [word for word in text.split() if word not in self.stop_words]
        return tokens

    def extract_key_terms(self, question: str) -> list:
        """Extract key terms from question, excluding question words."""
        tokens = self.preprocess_text(question)
        return [word for word in tokens if word not in self.question_words]

    def calculate_relevance(
        self, question: str, article_description: str
    ) -> Tuple[float, Dict]:
        """Calculate relevance between a question and article description."""
        question_terms = self.extract_key_terms(question)
        article_tokens = self.preprocess_text(article_description)

        if not question_terms or not article_tokens:
            return 0.0, {
                "topic_overlap": 0.0,
                "key_terms_coverage": 0.0,
                "context_relevance": 0.0,
            }

        q_set = set(question_terms)
        a_set = set(article_tokens)
        topic_overlap = len(q_set.intersection(a_set)) / len(q_set)

        q_terms = Counter(question_terms)
        a_terms = Counter(article_tokens)
        covered_terms = sum((q_terms & a_terms).values())
        key_terms_coverage = covered_terms / len(question_terms)

        context_matches = 0
        for i, token in enumerate(article_tokens):
            if token in question_terms:
                start = max(0, i - 3)
                end = min(len(article_tokens), i + 4)
                window = article_tokens[start:end]
                context_matches += len(set(window).intersection(q_set)) - 1

        max_possible_context = len(question_terms) * 6
        context_relevance = min(
            1.0,
            context_matches / max_possible_context if max_possible_context > 0 else 0,
        )

        weights = {
            "topic_overlap": 0.4,
            "key_terms_coverage": 0.4,
            "context_relevance": 0.2,
        }

        final_score = (
            topic_overlap * weights["topic_overlap"]
            + key_terms_coverage * weights["key_terms_coverage"]
            + context_relevance * weights["context_relevance"]
        )

        metrics = {
            "topic_overlap": round(topic_overlap, 3),
            "key_terms_coverage": round(key_terms_coverage, 3),
            "context_relevance": round(context_relevance, 3),
        }

        return round(final_score, 3), metrics


def analyze_article_relevance(question: str, article_description: str) -> float:
    """Analyze and return the relevance between a question and article description."""
    analyzer = ArticleRelevanceAnalyzer()
    score, metrics = analyzer.calculate_relevance(question, article_description)
    return score


# Example usage
if __name__ == "__main__":
    QUESTION = "What are the environmental impacts of plastic pollution?"
    ARTICLE_DESCRIPTION = (
        "This study examines the effects of microplastic contamination on marine ecosystems, "
        "focusing on how plastic debris affects marine life and ocean chemistry."
    )

    analyze_article_relevance(QUESTION, ARTICLE_DESCRIPTION)
