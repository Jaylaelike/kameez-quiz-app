import type { Quiz } from "../model/quiz";

export class ApiService {
    async getQuizById(id: string): Promise<Quiz | null> {
        let response = await fetch(import.meta.env.VITE_URL_BACKEND + `api/quizzes/${id}`);
        if (!response.ok) {
            return null;
        }

        let json = await response.json();
        return json;
    }

    async getQuizzes(): Promise<Quiz[]> {
        let response = await fetch(import.meta.env.VITE_URL_BACKEND + `api/quizzes`);
        if (!response.ok) {
            alert("Failed to fetch quizzes!");
            return [];
        }

        let json = await response.json();
        return json;
    }

    async saveQuiz(quizId: string, quiz: Quiz) {
        let response = await fetch(import.meta.env.VITE_URL_BACKEND + `api/quizzes/${quizId}`, {
            method: "PUT",
            body: JSON.stringify(quiz),
            headers: {
                "Content-Type": "application/json"
            }
        });

        if (!response.ok) {
            alert("Failed to save quiz!");
            return;
        }
    }
}

export const apiService = new ApiService();
