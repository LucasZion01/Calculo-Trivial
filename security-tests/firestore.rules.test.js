import { after, before, beforeEach, test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from '@firebase/rules-unit-testing';

import {
  doc,
  getDoc,
  serverTimestamp,
  setDoc,
} from 'firebase/firestore';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const projectId = 'calculo-trivial-security-audit';

let testEnv;

function validProgress(overrides = {}) {
  return {
    completedLessonIds: [],
    completedContentLessonIds: [],

    algebraFundamentalCompleted: false,
    equationsAndInequationsCompleted: false,
    functionsCompleted: false,
    limitsCompleted: false,
    continuityCompleted: false,
    derivativesCompleted: false,

    totalXp: 0,
    totalGold: 0,

    totalAnswerAttempts: 0,
    correctAnswerAttempts: 0,
    incorrectAnswerAttempts: 0,
    accuracy: 0,

    studyStreak: 0,
    lastStudyDate: null,

    dailyAnsweredQuestions: 0,
    dailyQuestionGoal: 5,
    dailyActivityDate: null,

    lastQuestionSessionIds: {},
    lastFinalTestSessionIds: {},

    updatedAt: serverTimestamp(),

    ...overrides,
  };
}

async function seedProgress(uid, data = validProgress()) {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();

    await setDoc(
      doc(db, 'users', uid, 'progress', 'current'),
      data,
    );
  });
}

before(async () => {
  const rules = readFileSync(
    resolve(__dirname, '..', 'firestore.rules'),
    'utf8',
  );

  testEnv = await initializeTestEnvironment({
    projectId,
    firestore: {
      rules,
      host: '127.0.0.1',
      port: 8080,
    },
  });
});

beforeEach(async () => {
  await testEnv.clearFirestore();
});

after(async () => {
  await testEnv.cleanup();
});

test('usuário autenticado consegue ler o próprio progresso', async () => {
  await seedProgress('user-a');

  const db = testEnv
    .authenticatedContext('user-a')
    .firestore();

  await assertSucceeds(
    getDoc(
      doc(db, 'users', 'user-a', 'progress', 'current'),
    ),
  );
});

test('usuário anônimo não consegue ler progresso privado', async () => {
  await seedProgress('user-a');

  const db = testEnv
    .unauthenticatedContext()
    .firestore();

  await assertFails(
    getDoc(
      doc(db, 'users', 'user-a', 'progress', 'current'),
    ),
  );
});

test('usuário A não consegue ler nem alterar progresso do usuário B', async () => {
  await seedProgress('user-b');

  const db = testEnv
    .authenticatedContext('user-a')
    .firestore();

  const otherUserProgress = doc(
    db,
    'users',
    'user-b',
    'progress',
    'current',
  );

  await assertFails(
    getDoc(otherUserProgress),
  );

  await assertFails(
    setDoc(
      otherUserProgress,
      validProgress(),
    ),
  );
});

test('Firestore rejeita campo inesperado no progresso', async () => {
  const db = testEnv
    .authenticatedContext('user-a')
    .firestore();

  await assertFails(
    setDoc(
      doc(db, 'users', 'user-a', 'progress', 'current'),
      validProgress({
        admin: true,
      }),
    ),
  );
});

test('CARACTERIZAÇÃO P1: usuário consegue fabricar o próprio progresso completo', async () => {
  const db = testEnv
    .authenticatedContext('user-a')
    .firestore();

  const forgedProgress = validProgress({
    completedLessonIds: [
      'algebra-fundamental',
      'equacoes-inequacoes',
      'funcoes',
      'limites',
      'continuidade',
      'derivadas',
    ],

    algebraFundamentalCompleted: true,
    equationsAndInequationsCompleted: true,
    functionsCompleted: true,
    limitsCompleted: true,
    continuityCompleted: true,
    derivativesCompleted: true,

    totalXp: 510,
    totalGold: 225,

    totalAnswerAttempts: 100,
    correctAnswerAttempts: 100,
    incorrectAnswerAttempts: 0,
    accuracy: 1,
    studyStreak: 999,
  });

  await assertSucceeds(
    setDoc(
      doc(db, 'users', 'user-a', 'progress', 'current'),
      forgedProgress,
    ),
  );

  const snapshot = await getDoc(
    doc(db, 'users', 'user-a', 'progress', 'current'),
  );

  assert.equal(snapshot.exists(), true);
  assert.equal(snapshot.data().totalXp, 510);
  assert.equal(snapshot.data().totalGold, 225);
  assert.equal(snapshot.data().derivativesCompleted, true);
});