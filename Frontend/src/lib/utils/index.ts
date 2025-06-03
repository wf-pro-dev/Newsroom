import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function mixArray<T>(arr1: T[], arr2: T[], maxConsecutive: number): T[] {
  const result: T[] = [];
  let i = 0, j = 0;
  let consecutive1 = 0, consecutive2 = 0;

  while (i < arr1.length && j < arr2.length) {
    if (consecutive1 < maxConsecutive && (consecutive2 >= maxConsecutive || Math.random() < 0.5)) {
      result.push(arr1[i++]);
      consecutive1++;
      consecutive2 = 0;
    } else {
      result.push(arr2[j++]);
      consecutive2++;
      consecutive1 = 0;
    }
  }

  // Add remaining elements
  while (i < arr1.length) result.push(arr1[i++]);
  while (j < arr2.length) result.push(arr2[j++]);

  return result;
} 